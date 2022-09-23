import datetime

from dateutil.relativedelta import relativedelta
from django.db.models import Q
from django.utils import timezone
from django.utils.timezone import now
from rest_framework import viewsets, authentication, permissions, generics
from rest_framework.decorators import action, api_view
from rest_framework.response import Response

from main.models import ClassDate, Review, Level
from subscription.serializers import *
import qrcode
from PIL import Image, ImageDraw
from io import BytesIO
from django.core.files import File


class SubscriptionViewset(viewsets.ModelViewSet):
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]
    queryset = Subscription.objects.all()
    serializer_class = SubscriptionSerializer

    @action(methods=['get'], detail=False)
    def check_subscription(self, request):
        user_id = request.GET.get('user_id', None)
        group_id = request.GET.get('group_id', None)

        subscriptions = Subscription.objects.filter(user_id=user_id, group_id=group_id, is_active=True)
        if subscriptions.exists():
            result = 0
            for subscription in subscriptions:
                if subscription.attendance:
                    attendance = subscription.attendance
                else:
                    attendance = 0
                total_attendance = 0
                total_lessons = 0
                instance_subscription = Subscription.objects.filter(group_id=subscription.group_id,
                                                                    user_id=subscription.user_id,
                                                                    is_active=True)
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
                return Response({"is_appear": True, "remaining_attendance": int(total_lessons) - int(total_attendance)},
                                200)
        else:
            return Response({"is_appear": False, "remaining_attendance": 0}, 200)

    @action(methods=['get'], detail=False)
    def create_invoice(self, request):
        user_id = request.GET.get("user_id", None)
        group_id = request.GET.get("group_id", None)
        card_number = request.GET.get("card_number", None)
        today = now().date()
        month = today.month + 1
        next_month = today + relativedelta(month=month)
        try:
            subscription = Subscription.objects.create(
                start_date=today,
                finish_date=next_month,
                user_id=user_id,
                group_id=group_id,
                is_paid=True,
            )
            user_instance = User.objects.get(id=user_id)
            user_instance.module_id = subscription.group.module_id
            user_instance.save()
            invoice = Invoice.objects.create(
                user_id=user_id,
                subscription_id=subscription.id,
                card_number=card_number,
                amount=subscription.group.level.price,
                module_id=subscription.group.level.clas.module_id,
            )
            data = [{
                "user_id": user_id,
                "module_id": subscription.group.level.clas.module_id,
                "course_id": subscription.group.level.clas_id,
                "module_name": subscription.group.level.clas.module.legal_name,
                "course_name": subscription.group.level.clas.name,
                "type_group": subscription.group.type_group,
                "group_name": subscription.group.name,
                "level": subscription.group.level.name,
                "card_number": card_number,
                "group_price": subscription.group.level.price,

            }]
            return Response(data, 201)
        except:
            return Response("Something went wrong", 400)

    @action(methods=['get'], detail=False)
    def create_free_subscription(self, request):
        user_id = request.GET.get("user_id", None)
        group_id = request.GET.get("group_id", None)

        if Operation.objects.filter(user_id=user_id, is_free=True, group_id=group_id).exists() or \
                Subscription.objects.filter(is_free=True, user_id=user_id, group_id=group_id).exists():
            return Response("This user has already taken a free lesson", status=400)
        else:
            subscription = Subscription.objects.create(
                user_id=user_id,
                group_id=group_id,
                is_free=True
            )
            user_instance = User.objects.get(id=user_id)
            user_instance.module_id = subscription.group.module_id
            user_instance.save()
            return Response("A free trial lesson has been created", status=201)

    @action(methods=['get'], detail=False)
    def get_timetable(self, request):
        class_id = request.GET.get("class_id", None)
        groups = Group.objects.filter(level__clas_id=class_id)
        dates = []
        data = []
        for i in range(1, 8):
            date = now().date() + datetime.timedelta(days=i)
            dates.append({
                "week": date.weekday() + 1,
                "day": date
            })
        for weekday in dates:
            data.append({
                "weekday": weekday.get("week", None),
                "day": weekday.get("day", None),
                "groups": []
            })
            for group in groups:
                class_date = ClassDate.objects.filter(group_id=group.id)
                for date in class_date:
                    group_weekday = []
                    for d in date.week:
                        group_weekday.append(d)
                    if str(weekday.get("week", None)) in group_weekday:
                        data[-1]['groups'].append({
                            "group_id": group.id,
                            "level_id": group.level.id,
                            "level_name": group.level.name,
                            "group_time": group.group_date_mobile,
                            "type": group.type_group,
                            "status": group.status,
                        })
        return Response(data)

    @action(methods=['get'], detail=False)
    def get_my_timetable(self, request):
        user_id = request.GET.get("user_id", None)
        subscriptions = Subscription.objects.filter(user_id=user_id, is_active=True)
        dates = []
        data = []
        for i in range(1, 8):
            date = now().date() + datetime.timedelta(days=i)
            dates.append({
                "week": date.weekday() + 1,
                "day": date
            })
        for weekday in dates:
            data.append({
                "weekday": weekday.get("week", None),
                "day": weekday.get("day", None),
                "groups": []
            })
            groups_id = []
            for subscription in subscriptions:
                class_date = ClassDate.objects.filter(group_id=subscription.group.id)
                for date in class_date:
                    group_weekday = []
                    for d in date.week:
                        group_weekday.append(d)
                    if str(weekday.get("week", None)) in group_weekday and subscription.group_id not in groups_id:
                        data[-1]['groups'].append({
                            "subscription_id": subscription.id,
                            "group_id": subscription.group.id,
                            "level_id": subscription.group.level.id,
                            "course_id": subscription.group.level.clas.id,
                            "course_name": subscription.group.level.clas.name,
                            "level_name": subscription.group.level.name,
                            "module_name": subscription.group.level.clas.module.legal_name,
                            "group_time": [],
                        })
                        groups_id.append(subscription.group_id)
                        for dt in subscription.group.group_date_mobile:
                            if dt['week'] == weekday.get("week", None) and len(data[-1]['groups'][0]['group_time']) < 1:
                                data[-1]['groups'][0]['group_time'].append(
                                    {
                                        "start_date": dt['start_date'],
                                        "finish_date": dt['finish_date']
                                    }
                                )
        return Response(data)


class SubscriptionGetViewset(viewsets.ModelViewSet):
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]
    queryset = Subscription.objects.all()
    serializer_class = SubscriptionGetSerializer

    @action(methods=['get'], detail=False)
    def change_attendance(self, request):
        subscription_id = request.GET.get("subscription_id", None)
        attendance = request.GET.get("attendance", None)

        subscription = Subscription.objects.get(id=subscription_id)
        subscription.attendance = attendance

        subscription.save()

        return Response("changed", status=200)

    @action(methods=['get'], detail=False)
    def free_attendance(self, request):
        operations = Operation.objects.filter(is_free=True)
        serializer = OperationSerializer(operations, many=True)
        return Response(serializer.data, status=201)

    @action(methods=['get'], detail=False)
    def filter_notification(self, request):
        # print(request.META)
        module_id = request.GET.get("module_id", None)
        start_date = request.GET.get("start_date", None)
        finish_date = request.GET.get("finish_date", None)
        subscriptions = Subscription.objects.filter(is_active=True, is_free=False,
                                                    group__level__clas__module_id=module_id, create_at__gte=start_date,
                                                    create_at__lte=finish_date).order_by("-create_at")

        free_subscriptions = Subscription.objects.filter(is_active=True, is_free=True,
                                                         group__level__clas__module_id=module_id,
                                                         create_at__gte=start_date,
                                                         create_at__lte=finish_date).order_by("-create_at")
        reviews = Review.objects.filter(Q(module_id=module_id) | Q(clas__module_id=module_id),
                                        create_at__gte=start_date,
                                        create_at__lte=finish_date).order_by("-create_at")

        data = [{
            "courses": [],
            "free_lessons": [],
            "reviews": []
        }]
        for subscription in subscriptions:
            data[0]['courses'].append({
                "user_id": subscription.user_id,
                "subscription_id": subscription.id,
                "user_full_name": f"{subscription.user.first_name} {subscription.user.last_name}",
                "phone_number": subscription.user.phone_number,
                "course_name": subscription.group.level.clas.name,
                "group_name": subscription.group.name,
                "level_name": subscription.group.level.name,
                "is_new": subscription.is_new,
                "lesson_time": subscription.group.group_date,
                "create_at": timezone.localtime(subscription.create_at),
            })
        for operation in free_subscriptions:
            data[0]['free_lessons'].append({
                "user_id": operation.user_id,
                "operation_id": operation.id,
                "user_full_name": f"{operation.user.first_name} {operation.user.last_name}",
                "phone_number": operation.user.phone_number,
                "course_name": operation.group.level.clas.name,
                "group_name": operation.group.name,
                "level_name": operation.group.level.name,
                "is_new": operation.is_new,
                "lesson_time": operation.group.group_date,
                "create_at": timezone.localtime(operation.create_at),
            })
        for review in reviews:
            data[0]['reviews'].append({
                "user_id": review.user_id,
                "review_id": review.id,
                "user_full_name": f"{review.user.first_name} {review.user.last_name}",
                "phone_number": review.user.phone_number,
                "class_name": None,
                "module_name": None,
                "rating": review.rate,
                "is_new": review.is_new,
                "comment": review.comment,
                "create_at": timezone.localtime(review.create_at),
            })
            if review.clas:
                data[0]['reviews'][-1]['class_name'] = review.clas.name
            if review.module:
                data[0]['reviews'][-1]['module_name'] = review.module.legal_name
        return Response(data, status=200)

    @action(methods=['get'], detail=False)
    def filter_notification_all(self, request):
        module_id = request.GET.get("module_id", None)
        start_date = request.GET.get("start_date", None)
        finish_date = request.GET.get("finish_date", None)
        subscriptions = Subscription.objects.filter(is_active=True, is_free=False,
                                                    group__level__clas__module_id=module_id, create_at__gte=start_date,
                                                    create_at__lte=finish_date).order_by("-create_at")

        free_subscriptions = Subscription.objects.filter(is_active=True, is_free=True,
                                                         group__level__clas__module_id=module_id,
                                                         create_at__gte=start_date,
                                                         create_at__lte=finish_date).order_by("-create_at")
        reviews = Review.objects.filter(create_at__gte=start_date,
                                        create_at__lte=finish_date).order_by("-create_at")

        data = [{
            "courses": [],
            "free_lessons": [],
            "reviews": []
        }]
        for subscription in subscriptions:
            data[0]['courses'].append({
                "user_id": subscription.user_id,
                "subscription_id": subscription.id,
                "user_full_name": f"{subscription.user.first_name} {subscription.user.last_name}",
                "phone_number": subscription.user.phone_number,
                "course_name": subscription.group.level.clas.name,
                "group_name": subscription.group.name,
                "level_name": subscription.group.level.name,
                "is_new": subscription.is_new,
                "lesson_time": subscription.group.group_date,
                "create_at": timezone.localtime(subscription.create_at),
            })
        for operation in free_subscriptions:
            data[0]['free_lessons'].append({
                "user_id": operation.user_id,
                "operation_id": operation.id,
                "user_full_name": f"{operation.user.first_name} {operation.user.last_name}",
                "phone_number": operation.user.phone_number,
                "course_name": operation.group.level.clas.name,
                "group_name": operation.group.name,
                "level_name": operation.group.level.name,
                "is_new": operation.is_new,
                "lesson_time": operation.group.group_date,
                "create_at": timezone.localtime(operation.create_at),
            })
        for review in reviews:
            data[0]['reviews'].append({
                "user_id": review.user_id,
                "review_id": review.id,
                "user_full_name": f"{review.user.first_name} {review.user.last_name}",
                "phone_number": review.user.phone_number,
                "class_name": None,
                "module_name": None,
                "rating": review.rate,
                "is_new": review.is_new,
                "comment": review.comment,
                "create_at": timezone.localtime(review.create_at),
            })
            if review.clas:
                data[0]['reviews'][-1]['class_name'] = review.clas.name
            if review.module:
                data[0]['reviews'][-1]['module_name'] = review.module.legal_name
        return Response(data, status=200)

    @action(methods=['get'], detail=False)
    def change_status(self, request):
        subscription_id = request.GET.get("subscription_id", None)
        review_id = request.GET.get("review_id", None)

        if subscription_id:
            subscription = Subscription.objects.get(id=subscription_id)
            subscription.is_new = "old"
            subscription.save()
        if review_id:
            review = Review.objects.get(id=review_id)
            review.is_new = "old"
            review.save()
        return Response("Changed", status=200)

    @action(methods=['get'], detail=False)
    def get(self, request):
        user_id = request.GET.get('user_id', None)
        subscriptions = Subscription.objects.filter(user_id=user_id)
        data = []
        data_ids = []
        for subscription in subscriptions:
            if subscription.attendance:
                attendance = subscription.attendance
            else:
                attendance = 0
            total_attendance = 0
            total_lessons = 0
            instance_subscription = Subscription.objects.filter(group_id=subscription.group_id,
                                                                user_id=subscription.user_id,
                                                                is_paid=True, is_in_group=True)
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
            if subscription.group_id not in data_ids:
                data.append(
                    {
                        "subscription_id": subscription.id,
                        "subscription_start_date": subscription.start_date,
                        "subscription_finish_date": subscription.finish_date,
                        "status": subscription.is_active,
                        "course_name": subscription.group.level.clas.name,
                        "level_name": subscription.group.level.name,
                        "level_duration": subscription.group.level.duration,
                        "group_id": subscription.group.id,
                        "group_name": subscription.group.name,
                        "module_name": subscription.group.level.clas.module.legal_name,
                        "module_phone_number": subscription.group.level.clas.module.phone_number,
                        "price": subscription.group.level.price,
                        "number_of_lessons": subscription.group.number_of_lessons_per_month,
                        "total_lessons": total_lessons,
                        "remaining_attendance": total_lessons - total_attendance,
                        "total_attendance": total_attendance,
                    }
                )
                data_ids.append(subscription.group_id)
        return Response(data, status=200)


class OperationViewset(viewsets.ModelViewSet):
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]
    queryset = Operation.objects.all()
    serializer_class = OperationSerializer

    @action(methods=['post'], detail=False)
    def create_demo_operation(self, request):
        user_id = request.data.get("user", None)
        subscription_id = request.data.get("subscription", None)
        subscription = Subscription.objects.get(id=subscription_id)
        operation = Operation.objects.create(
            user_id=user_id,
            group_id=subscription.group_id,
            subscription_id=subscription.id,
            is_free=True,
            status=1
        )
        return Response("Created", 201)

    @action(methods=['post'], detail=False)
    def create_debt_operation(self, request):
        user_id = request.data.get("user_id", None)
        subscription_id = request.data.get("subscription_id", None)
        subscription = Subscription.objects.get(id=subscription_id)

        number_debt_operations = Operation.objects.filter(user_id=user_id, subscription_id=subscription_id,
                                                          is_debt=True).count()

        if number_debt_operations < 4:
            operation = Operation.objects.create(
                user_id=user_id,
                group_id=subscription.group_id,
                subscription_id=subscription.id,
                is_debt=True,
                status=1
            )
            subscription.attendance += 1
            subscription.save()
            return Response("Посещаемость успешно создана", 201)
        else:
            return Response("Количество кредитов для этой группы достигло предела", 400)

    @action(methods=['post'], detail=False)
    def create_operation(self, request):
        user_id = request.data.get("user", None)
        subscription_id = request.data.get("subscription", None)
        subscription = Subscription.objects.get(id=subscription_id)
        todays_week = now().weekday() + 1

        if subscription.is_paid != True:
            return Response("подписка не оплачена", 400)
        elif subscription.create_at.weekday() != todays_week:
            return Response("Ошибка. У данной группы сегодня нет занятий", 400)
        elif subscription.finish_date < now().date():
            return Response("cрок действия подписки истек", 400)
        elif subscription.attendance > subscription.group.number_of_lessons_per_month:
            return Response("cрок действия подписки истек", 400)
        elif subscription.is_active != True:
            return Response("подписка не активна", 400)
        elif subscription.is_active == True:
            operation = Operation.objects.filter(subscription_id=subscription.id, user_id=user_id)
            isFree = False
            if operation:
                for op in operation:
                    if op.is_free == True:
                        isFree = True
                if operation.last().create_at.date() == now().date() or isFree == True:
                    return Response("Этот пользователь уже использовал свою попытку на сегодня", status=203)
                elif isFree == False and subscription.is_free == True:
                    operation = Operation.objects.create(
                        user_id=user_id,
                        group_id=subscription.group_id,
                        subscription_id=subscription.id,
                        is_free=True,
                        status=1
                    )
                    subscription.attendance += 1
                    subscription.save()
                    return Response("Operation created", status=201)

                else:
                    operation = Operation.objects.create(
                        user_id=user_id,
                        group_id=subscription.group_id,
                        subscription_id=subscription.id,
                        status=1
                    )
                    subscription.attendance += 1
                    subscription.save()
                    return Response("Operation created", status=201)
            elif subscription.is_free == False:
                operation = Operation.objects.create(
                    user_id=user_id,
                    group_id=subscription.group_id,
                    subscription_id=subscription.id,
                    status=1
                )
                subscription.attendance += 1
                subscription.save()
                return Response("Operation created", status=201)
            else:
                operation = Operation.objects.create(
                    user_id=user_id,
                    group_id=subscription.group_id,
                    subscription_id=subscription.id,
                    is_free=True,
                    status=1
                )
                subscription.attendance += 1
                subscription.save()
                return Response("Operation created", status=201)

    @action(methods=['get'], detail=False)
    def check_subscription(self, request):
        user_id = request.GET.get("user_id", None)
        module_id = request.GET.get("module_id", None)
        subscriptions = Subscription.objects.filter(user_id=user_id, is_active=True,
                                                    group__level__clas__module_id=module_id)
        data = []
        data_gr = []
        user_subscriptions = Subscription.objects.filter(user_id=user_id)
        if subscriptions.exists():
            for subscription in subscriptions:
                if subscription.group_id not in data_gr:
                    data.append({
                        "module_id": module_id,
                        "subscription_id": subscription.id,
                        "module_name": subscription.group.level.clas.module.legal_name,
                        "qr_code": None,
                        "course_name": subscription.group.level.clas.name,
                        "course_price": subscription.group.level.price,
                        "course_duration": subscription.group.level.duration,
                        "group_id": subscription.group.id,
                        "group_name": subscription.group.name,
                        "group_type": subscription.group.type_group,
                        "level_name": subscription.group.level.name,
                        "group_time": subscription.group.group_date_mobile,
                    })
                    data_gr.append(subscription.group_id)
                    if subscription.group.level.clas.module.qr_code:
                        data[-1]['qr_code'] = subscription.group.level.clas.module.qr_code.url
            return Response(data, status=201)
        elif not user_subscriptions.exists():
            return Response("This user does not have a subscription", status=400)
        elif not subscriptions.exists():
            return Response("This user does not have a subscription", status=400)
        else:
            return Response("This user does not have a subscription", status=400)

    @action(methods=['get'], detail=False)
    def get_attendance(self, request):
        user_id = request.GET.get("user_id", None)
        operation = Operation.objects.filter(user_id=user_id)
        data = []
        for i in operation:
            data.append(dict(
                module_name=i.subscription.group.level.clas.module.legal_name,
                module_id=i.subscription.group.level.clas.module.id,
                course_name=i.subscription.group.level.clas.name,
                course_id=i.subscription.group.level.clas.id,
                level_name=i.subscription.group.level.name,
                level_id=i.subscription.group.level.id,
                date=timezone.localtime(i.create_at),
                time=None,
            ))
            class_date = ClassDate.objects.filter(group_id=i.subscription.group.id)
            for date in class_date:
                all_date = []
                for d in date.week:
                    all_date.append(d)
                if str(i.create_at.weekday() + 1) in all_date:
                    data[-1]['time'] = [date.start_date, date.finish_date]

        return Response(data, status=200)

    @action(methods=['get'], detail=False)
    def get_missed_attendance(self, request):
        user_id = request.GET.get("user_id", None)
        operation = Operation.objects.filter(Q(status=2) | Q(status=3), user_id=user_id, )
        operation_count = Operation.objects.filter(user_id=user_id).count()
        data = []
        for i in operation:
            data.append(dict(
                module_name=i.subscription.group.level.clas.module.legal_name,
                module_id=i.subscription.group.level.clas.module.id,
                course_name=i.subscription.group.level.clas.name,
                course_id=i.subscription.group.level.clas.id,
                level_name=i.subscription.group.level.name,
                level_id=i.subscription.group.level.id,
                date=timezone.localtime(i.update_at),
                status=i.status,
                time=None,
            ))
            class_date = ClassDate.objects.filter(group_id=i.subscription.group.id)
            for date in class_date:
                all_date = []
                for d in date.week:
                    all_date.append(d)
                if str(i.create_at.weekday() + 1) in all_date:
                    data[-1]['time'] = [date.start_date, date.finish_date]
        return Response(data, status=200)

    @action(methods=['post'], detail=False)
    def post(self, request):
        data = request.data
        subscription_id = data['subscription']

        subscription = Subscription.objects.get(id=subscription_id)
        if subscription.is_active != True:
            return Response("subscription is not active", 400)
        elif subscription.is_paid != True:
            return Response("subscription is unpaid", 400)
        elif subscription.finish_date < now().date():
            return Response("subscription expired", 400)
        elif subscription.attendance > subscription.group.number_of_lessons_per_month:
            return Response("subscription expired", 400)
        elif subscription.is_active == True:
            serializer = OperationSerializer(data=data)
            if serializer.is_valid():
                serializer.is_valid(raise_exception=True)
                serializer.save()
                subscription.attendance += 1
                subscription.save()
                return Response(serializer.data, 201)
            return Response(serializer.errors)
        else:
            return Response("Something went wrong")

    @action(methods=['get'], detail=False)
    def cron_attendance(self, request):
        subscription = Subscription.objects.filter(is_active=True)
        now_weekday = str(now().weekday() + 1)
        for sub in subscription:
            all_weekday = []
            class_date = ClassDate.objects.filter(status=2, group_id=sub.group.id)
            for clas in class_date:
                for w in clas.week:
                    if w not in all_weekday:
                        all_weekday.append(w)
            oper = Operation.objects.filter(subscription_id=sub.id)
            if oper.last():
                operation_week_day = str(oper.last().create_at.weekday() + 1)
                if now_weekday in all_weekday and operation_week_day != now_weekday:
                    operation_instance = Operation.objects.create(
                        is_missed=True,
                        subscription_id=sub.id,
                        user_id=sub.user_id,
                        status=3
                    )
                    sub.attendance += 1
                    sub.save()
        return Response("Checked")

    @action(methods=['post'], detail=False)
    def create_qr_image(self, request):
        module_id = request.data.get("module_id")
        module = Module.objects.get(id=module_id)
        if module.qr_code:
            data = [{
                "qr_code": module.qr_code.url
            }]
            return Response(data, status=200)
        else:
            qrcode_img = qrcode.make(module_id)
            canvas = Image.new("RGB", (300, 300), "white")
            draw = ImageDraw.Draw(canvas)
            canvas.paste(qrcode_img)
            buffer = BytesIO()
            canvas.save(buffer, "PNG")
            module.qr_code.save(f'image{module.legal_name}.png', File(buffer), save=False)
            canvas.close()
            module.save()
            data = [{
                "qr_code": module.qr_code.url
            }]
            return Response(data, status=201)

    @action(methods=['get'], detail=False)
    def get_subscription_details(self, request):
        subscription_id = request.GET.get("subscription_id", None)
        subscription = Subscription.objects.filter(id=subscription_id)
        if subscription_id:
            sub = subscription.last()
            data = [{
                "module_id": sub.group.level.clas.module_id,
                "subscription_id": sub.id,
                "module_name": sub.group.level.clas.module.legal_name,
                "qr_code": None,
                "course_name": sub.group.level.clas.name,
                "group_name": sub.group.name,
                "group_type": sub.group.status,
                "level_name": sub.group.level.name,
                "group_time": sub.group.group_time,
            }]
            if subscription.last().group.level.clas.module.qr_code:
                data[-1]['qr_code'] = subscription.last().group.level.clas.module.qr_code.url
            return Response(data, status=201)
        else:
            return Response("Subscription not found", status=400)
