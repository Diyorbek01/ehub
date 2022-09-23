from dateutil.relativedelta import relativedelta
from django.db.models import Q
from django.shortcuts import render

# Create your views here.
from django.utils import timezone
from django.utils.timezone import now
from rest_framework import viewsets, authentication, permissions
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.status import HTTP_200_OK, HTTP_201_CREATED
from rest_framework.views import APIView

from erp_main.models import Achievment
from erp_main.serializers import GroupGetSerializer, GroupGetDetailsSerializer
from erp_operation.serializers import AchievmentSerializer, LevelSerializer
from main.models import Level, Group, ClassDate, User
from main.serializers import GroupSerializer
from subscription.models import Subscription, Operation


def count_students(group_id):
    subscriptions = Subscription.objects.filter(group_id=group_id, is_active=True, is_paid=True, is_in_group=True)
    users = []
    for subscription in subscriptions:
        if subscription.user_id not in users and subscription.user.is_delete == False:
            users.append(subscription.user_id)
    return len(users)


def get_students(group_id):
    all_subscriptions = Subscription.objects.filter(group_id=group_id, is_in_group=True).order_by('-is_active', 'id')
    active_subscriptions = [sub_id.id for sub_id in
                            Subscription.objects.filter(group_id=group_id, is_active=True, is_paid=True)]
    all_subscription_users = [user_id.user.id for user_id in
                              Subscription.objects.filter(group_id=group_id, is_in_group=True)]
    users = []
    active_users_id = []
    inactive_users_id = []
    for sb in all_subscriptions:
        if int(sb.group.number_of_lessons_per_month) >= int(
                sb.attendance) and sb.user_id not in active_users_id and sb.user.is_delete == False and sb.is_active_user and sb.id in active_subscriptions:
            users.append({
                "id": sb.user.id,
                "subscription_id": sb.id,
                "first_name": sb.user.first_name,
                "last_name": sb.user.last_name,
                "is_active": True,
                "is_active_user": True,
                "attendance": [],
            })
            active_users_id.append(sb.user_id)
        else:
            if sb.user.id in all_subscription_users and sb.user.is_delete == False and sb.is_active_user == False and sb.user_id not in inactive_users_id and sb.user_id not in active_users_id:
                users.append({
                    "id": sb.user.id,
                    "subscription_id": sb.id,
                    "first_name": sb.user.first_name,
                    "last_name": sb.user.last_name,
                    "is_active": False,
                    "is_active_user": False,
                    "attendance": [],

                })
                inactive_users_id.append(sb.user_id)
                active_users_id.append(sb.user_id)
    return users


def default_create_attendance(group_id):
    students_list = get_students(group_id)
    number_attendance = []
    for student in students_list:
        number_attendance.append(Operation.objects.filter(user_id=student['id'],
                                                          group_id=group_id).count())
    for s in students_list:
        number = Operation.objects.filter(user_id=s['id'], group_id=group_id).count()
        if number < number_attendance[0]:
            new_attendance = number_attendance[0] - number
            for i in range(1, new_attendance + 1):
                operation = Operation.objects.create(
                    user_id=s['id'],
                    group_id=group_id,
                    subscription_id=s['subscription_id'],
                    status=4
                )
    return "Success"


class LevelViewset(viewsets.ModelViewSet):
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]
    queryset = Level.objects.filter(is_delete=False)
    serializer_class = LevelSerializer


class AchievmentViewset(viewsets.ModelViewSet):
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]
    queryset = Achievment.objects.all()
    serializer_class = AchievmentSerializer


class GroupViewset(viewsets.ModelViewSet):
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]
    queryset = Group.objects.filter(is_delete=False)
    serializer_class = GroupSerializer

    @action(methods=['get'], detail=False)
    def delete(self, request):
        id = request.GET.get("id", None)
        group = Group.objects.get(id=id)
        group.is_delete = True
        group.save()
        return Response("Delete", status=HTTP_200_OK)

    @action(methods=['get'], detail=False)
    def get(self, request):
        module_id = request.GET.get("id", None)

        classes = Group.objects.filter(is_delete=False, module_id=module_id)
        serializer = GroupGetSerializer(classes, many=True)
        return Response(serializer.data, status=HTTP_200_OK)

    @action(methods=['get'], detail=False)
    def get_details(self, request):
        group_id = request.GET.get("id", None)
        classes = Group.objects.get(id=group_id, is_delete=False)
        serializer = GroupGetDetailsSerializer(classes)
        return Response(serializer.data, status=HTTP_200_OK)

    @action(methods=['post'], detail=False)
    def update_group(self, request):
        data = request.data
        group = request.data.get("group", None)
        group_time = data.get("group_time", None)

        group_instance = Group.objects.get(id=group.get("id", None))
        group_instance.name = group.get("name", None)
        group_instance.number_of_lessons_per_month = group.get("number_of_lessons_per_month", None)
        group_instance.current_students_number = group.get("current_students_number", None)
        group_instance.current_students_number = group.get("limit", None)
        group_instance.status = group.get("status", None)
        group_instance.type_group = group.get("type_group", None)
        group_instance.duration = group.get("duration", None)
        group_instance.save()
        delete_gr = ClassDate.objects.filter(group_id=group.get("id", None)).delete()
        for gr in group_time:
            if gr.get("id"):
                instance = ClassDate.objects.create(
                    id=gr.get("id", None),
                    week=gr.get("week", None),
                    status=2,
                    start_date=gr.get("start_date", None),
                    finish_date=gr.get("finish_date", None),
                    group_id=group_instance.id
                )
            else:
                instance = ClassDate.objects.create(
                    week=gr.get("week", None),
                    start_date=gr.get("start_date", None),
                    finish_date=gr.get("finish_date", None),
                    group_id=group_instance.id,
                    status=2,
                )

        return Response({
            "message": "Updated",
            "id": group_instance.id,
        })

    @action(methods=['post'], detail=False)
    def post(self, request):
        data = request.data
        group = request.data.get("group", None)
        group_time = data.get("group_time", None)

        group_instance = Group.objects.create(
            **group
        )
        for gr in group_time:
            class_date = ClassDate.objects.create(
                **gr,
                group_id=group_instance.id,
                status=2
            )

        return Response({
            "message": "created",
            "id": group_instance.id,
        })

    @action(methods=['post'], detail=False)
    def add_student(self, request):
        group_id = request.data.get("group_id", None)
        user_id = request.data.get("user_id", None)
        for user in user_id:
            subscription = Subscription.objects.create(
                group_id=group_id,
                user_id=user,
                is_paid=True,
                is_active=True,
                is_new=False
            )
        group = Group.objects.get(id=group_id)
        group.current_students_number = count_students(group_id)
        group.save()
        return Response("Added", 201)

    @action(methods=['post'], detail=False)
    def create_subscription(self, request):
        group_id = request.data.get("group_id", None)
        user_id = request.data.get("user_id", None)
        subscription_id = request.data.get("subscription_id", None)
        start_date = request.data.get("start_date", None)
        finish_date = request.data.get("finish_date", None)
        attendance = request.data.get("attendance", None)
        if subscription_id is None:
            subscription = Subscription.objects.create(
                group_id=group_id,
                user_id=user_id,
                is_paid=True,
                attendance=attendance,
                is_new=False

            )
            user_instance = User.objects.get(id=user_id)
            user_instance.module_id = subscription.group.module_id
            user_instance.save()


        else:
            subscription_instance = Subscription.objects.get(id=subscription_id)
            subscription_instance.group_id = group_id
            subscription_instance.user_id = user_id
            subscription_instance.is_paid = True
            subscription_instance.start_date = start_date
            subscription_instance.finish_date = finish_date
            subscription_instance.attendance = attendance
            subscription_instance.save()

            user_instance = User.objects.get(id=user_id)
            user_instance.module_id = subscription_instance.group.module_id
            user_instance.save()

        return Response("Created", status=HTTP_201_CREATED)

    @action(methods=['get'], detail=False)
    def remove_student(self, request):
        group_id = request.GET.get("group_id", None)
        user_id = request.GET.get("user_id", None)
        subscriptions = Subscription.objects.filter(group_id=group_id, user_id=user_id, is_paid=True)
        for sb in subscriptions:
            sb.is_in_group = False
            sb.save()
        group = Group.objects.get(id=group_id)
        group.current_students_number = count_students(group_id)
        group.save()
        return Response("Deleted", status=HTTP_200_OK)
    @action(methods=['get'], detail=False)
    def deactivate_student(self, request):
        group_id = request.GET.get("group_id", None)
        user_id = request.GET.get("user_id", None)
        subscriptions = Subscription.objects.filter(group_id=group_id, user_id=user_id, is_paid=True)
        for sb in subscriptions:
            sb.is_active_user = False
            sb.save()
        group = Group.objects.get(id=group_id)
        group.current_students_number = count_students(group_id)
        group.save()
        return Response("Deleted", status=HTTP_200_OK)

    @action(methods=['get'], detail=False)
    def get_students(self, request):
        group_id = request.GET.get("group_id", None)
        subscriptions = Subscription.objects.filter(group_id=group_id, is_in_group=True).order_by('-is_active', 'id')
        all_subscriptions = [user_id.user.id for user_id in Subscription.objects.filter(group_id=group_id)]
        active_subscriptions = [sub_id.id for sub_id in
                                Subscription.objects.filter(group_id=group_id, is_active=True, is_paid=True)]
        default_create_attendance(group_id)
        users = []
        active_users_id = []
        inactive_users_id = []
        for sb in subscriptions:
            if sb.attendance:
                attendance = sb.attendance
            else:
                attendance = 0
            total_attendance = 0
            total_lessons = 0
            instance_subscription = Subscription.objects.filter(group_id=sb.group_id,
                                                                user_id=sb.user_id, is_paid=True, is_in_group=True)
            for ins in instance_subscription:
                if ins.attendance:
                    ins_attendance = ins.attendance
                else:
                    ins_attendance = 0
                if ins.group.number_of_lessons_per_month:
                    ins_months = ins.group.number_of_lessons_per_month
                else:
                    ins_months = 0
                total_attendance += int(ins_attendance)
                total_lessons += int(ins_months)
            if int(sb.group.number_of_lessons_per_month) >= int(
                    attendance) and sb.user_id not in active_users_id and sb.user.is_delete == False and sb.id in active_subscriptions and sb.is_active_user:
                users.append({
                    "id": sb.user.id,
                    "subscription_id": sb.id,
                    "first_name": sb.user.first_name,
                    "last_name": sb.user.last_name,
                    "phone_number": sb.user.phone_number,
                    "is_active": True,
                    "is_active_user": True,
                    "total_lessons": total_lessons,
                    "remaining_attendance": total_lessons - total_attendance,
                    "total_attendance": total_attendance,
                    "update_at": timezone.localtime(sb.update_at)
                })
                active_users_id.append(sb.user_id)
            else:
                if sb.user.id in all_subscriptions and sb.user.is_delete == False and sb.is_active_user == False and sb.user_id not in inactive_users_id and sb.user_id not in active_users_id:
                    users.append({
                        "id": sb.user.id,
                        "subscription_id": sb.id,
                        "first_name": sb.user.first_name,
                        "last_name": sb.user.last_name,
                        "phone_number": sb.user.phone_number,
                        "is_active": False,
                        "is_active_user": True,
                        "total_lessons": total_lessons,
                        "remaining_attendance": total_lessons - total_attendance,
                        "total_attendance": total_attendance,
                        "update_at": timezone.localtime(sb.update_at)
                    })
                    inactive_users_id.append(sb.user_id)
                    active_users_id.append(sb.user_id)
        return Response(users, status=HTTP_200_OK)

    @action(methods=['get'], detail=False)
    def get_students_all(self, request):
        group_id = request.GET.get("group_id", None)
        module_id = request.GET.get("module_id", None)
        all_subscriptions = [user_id.user.id for user_id in
                             Subscription.objects.filter(group_id=group_id, is_in_group=True)]

        students = User.objects.filter(role="student", is_user=False, is_delete=False, module_id=module_id)
        users = []
        for student in students:
            if student.id not in all_subscriptions:
                users.append({
                    "id": student.id,
                    "full_name": f"{student.first_name} {student.last_name}",
                })

        return Response(users, status=HTTP_200_OK)

    @action(methods=['post'], detail=False)
    def create_attendance(self, request):
        data = request.data.get("data")
        subscription_id = data[0].get("subscription_id")
        subscription = Subscription.objects.get(id=subscription_id)

        all_weeks = []
        weeks = subscription.group.group_week
        for week in weeks:
            all_weeks.append(int(week[0]))
        if now().weekday() + 1 in all_weeks:
            for i in data:
                user_id = i.get("user_id", None)
                group_id = i.get("group_id", None)
                subscripton_id = i.get("subscription_id", None)
                status = i.get("status", None)
                subscription = Subscription.objects.get(id=subscripton_id)

                attendance = Operation.objects.create(
                    user_id=user_id,
                    group_id=group_id,
                    status=status,
                    subscription_id=subscripton_id
                )

            return Response("Created", status=HTTP_201_CREATED)
        else:
            return Response("Ошибка. У данной группы сегодня нет занятий", status=400)

    @action(methods=['get'], detail=False)
    def get_attendance(self, request):
        group_id = request.GET.get("group_id", None)
        students_list = get_students(group_id)
        for student in students_list:
            operations = Operation.objects.filter(user_id=student['id'],
                                                  group_id=group_id).order_by('create_at')
            for operation in operations:
                student["attendance"].append({
                    "id": operation.id,
                    "status": operation.status,
                    "create_at": timezone.localtime(operation.create_at),
                })
        return Response(students_list)

    @action(methods=['post'], detail=False)
    def update_attendance(self, request):
        subscription_id = request.data.get("subscription_id", None)
        operation_id = request.data.get("operation_id", None)
        status = request.data.get("status", None)
        old_status = request.data.get("old_status", None)
        operation = Operation.objects.get(id=operation_id)
        operation.status = status
        operation.save()
        subscription = Subscription.objects.get(id=subscription_id)
        if old_status == 1 and status == 2:
            subscription.attendance -= 1
        elif old_status == 2 and status == 1:
            subscription.attendance += 1
        elif old_status == 2 and status == 3:
            subscription.attendance += 1
        elif old_status == 3 and status == 2:
            subscription.attendance -= 1
        elif old_status == 3 and status == 1:
            pass
        elif old_status == 1 and status == 3:
            pass
        elif old_status == 4 and status == 2:
            pass
        elif old_status == 4 and status == 1:
            subscription.attendance += 1
        elif old_status == 4 and status == 3:
            subscription.attendance += 1
        subscription.save()

        return Response("Changed")


class CronJob(APIView):
    def get(self, request):
        print("heello")
        subscriptons = Subscription.objects.all()
        for subscription in subscriptons:
            if subscription.finish_date is not None:
                if subscription.is_in_group and subscription.is_paid and subscription.finish_date > now().date():
                    subscription.is_active = True
                    subscription.save()
                else:
                    subscription.is_active = False
                    subscription.save()
        return Response("Checked")
