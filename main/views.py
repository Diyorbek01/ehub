import json
import os
from _ast import mod
from datetime import datetime
from wsgiref.util import FileWrapper

from django.db.models import Q
from django.http import HttpResponse, FileResponse
from rest_framework import viewsets, authentication, permissions
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.status import *

from main.serializers import *
from mobile.serializers import UserInfoGetMobileSerializer

week_obj = dict(
    Mon=1,
    Tue=2,
    Wed=3,
    Thu=4,
    Fri=5,
    Sat=6,
    Sun=7,
)


def download_image(request, id):
    module = Module.objects.get(id=id)
    pdf_file = os.path.abspath(f"media/{module.qr_code.name}")
    with open(pdf_file, 'rb') as pdf:
        response = HttpResponse(pdf.read(), content_type='application/png')
        response['Content-Disposition'] = 'inline;filename=qr code.png'
        return response


class ModuleViewset(viewsets.ModelViewSet):
    queryset = Module.objects.all()
    serializer_class = ModuleSerializer

    @action(methods=['post'], detail=False)
    def post(self, request):
        logo = request.FILES.get("logo", None)
        partner_images = request.FILES.getlist("partner-image", None)
        clas = request.data['class']
        data = json.loads(clas)
        module_data = data['module']
        module = Module.objects.create(
            legal_name=module_data['legal_name'],
            address=module_data['address'],
            phone_number=module_data['phone_number'],
            description=module_data['description'],
            password=module_data['password'],
            logo=logo,
            contact_name=module_data['contact_name'],
            location1=module_data['location'][0],
            location2=module_data['location'][1],
        )
        for image in partner_images:
            Images.objects.create(
                module_id=module.id,
                file=image
            )
        for i in module_data['facilities']:
            module.facilities.add(i)
            module.save()
        opening_date = module_data['opening_date']
        for i in opening_date:
            ClassDate.objects.create(
                **i,
                module_id=module.id,
                status=1
            )
        return Response("Created", 201)

    @action(methods=['post'], detail=False)
    def edit(self, request):
        # image = request.data.getlist('image')
        logo = request.FILES.get("logo", None)
        partner_images = request.FILES.getlist("partner-image", None)
        clas = request.data['class']
        data = json.loads(clas)
        datas = data['class']
        module_data = data['module']
        module_id = module_data['id']
        module = Module.objects.get(id=module_id)

        module.legal_name = module_data['legal_name']
        module.address = module_data['address']
        module.phone_number = module_data['phone_number']
        module.description = module_data['description']
        module.logo = logo
        module.contact_name = module_data['contact_name']
        module.location1 = module_data['location'][0]
        module.location2 = module_data['location'][1]
        module.save()

        module.facilities.clear()
        for i in module_data['facilities']:
            module.facilities.add(i)
            module.save()

        Images.objects.filter(module_id=module.id).delete()
        for image in partner_images:
            Images.objects.create(
                module_id=module.id,
                file=image
            )
        opening_date = module_data['opening_date']
        for i in opening_date:
            classdate_id = i.get('id', None)
            if classdate_id:
                classdate = ClassDate.objects.get(id=i['id'])
                classdate.start_date = i['start_date']
                classdate.finish_date = i['finish_date']
                classdate.save()

            else:
                classdate = ClassDate.objects.create(
                    start_date=i['start_date'],
                    finish_date=i['start_date'],
                    module_id=module_id,
                    status=1
                )
            classdate.week.clear()
            for w in i['week']:
                classdate.week.append(w)
        return Response("Create", 201)

    @action(methods=['get'], detail=False)
    def change_status(self, request):
        id = request.GET.get("id", None)
        status = request.GET.get("status", None)
        try:
            module = Module.objects.get(id=id)
            module.status = status
            module.save()
            return Response("Changes", status=HTTP_200_OK)
        except:
            return Response("Module doesn't exist", status=HTTP_400_BAD_REQUEST)

    @action(methods=['get'], detail=False)
    def filter_status(self, request):
        status = request.GET.get("status", None)
        module = Module.objects.filter(status=status)
        serializer = ModuleSerializer(module, many=True)
        return Response(serializer.data, status=HTTP_200_OK)

    @action(methods=['get'], detail=False)
    def get(self, request):
        modules = Module.objects.filter(~Q(status="delete"))
        data = []
        for module in modules:
            if module.logo:
                data.append({
                    "id": module.id,
                    "facilities": [x.id for x in Variant.objects.filter(module=module.id)],
                    "legal_name": module.legal_name,
                    "address": module.address,
                    "contact_name": module.contact_name,
                    "status": module.status,
                    "phone_number": module.phone_number,
                    "description": module.description,
                    "location": module.location,
                    "opening_hours": module.opening_hours,
                    "logo": module.logo.url,
                    "images": module.images,
                    "classes": '',
                    "rating": module.rating,
                    "reviews": module.reviews,
                    "password": module.password,
                    "number_reviews": module.number_reviews,
                })
            else:
                data.append({
                    "id": module.id,
                    "facilities": [x.id for x in Variant.objects.filter(module=module.id)],
                    "legal_name": module.legal_name,
                    "address": module.address,
                    "contact_name": module.contact_name,
                    "status": module.status,
                    "phone_number": module.phone_number,
                    "description": module.description,
                    "location": module.location,
                    "opening_hours": module.opening_hours,
                    "logo": None,
                    "images": module.images,
                    "classes": '',
                    "rating": module.rating,
                    "reviews": module.reviews,
                    "password": module.password,
                    "number_reviews": module.number_reviews,

                })

            question = Class.objects.filter(module=module.id)
            serailizer = ClassSerializer(question, many=True)
            classes = [c for c in serailizer.data]
            data[-1]['classes'] = classes
        return Response(data, status=200)

    @action(methods=['get'], detail=False)
    def delete(self, request):
        id = request.GET.get('id')
        module = Module.objects.get(id=id)
        module.status = "delete"
        module.save()
        return Response("Delete")


class ClassViewset(viewsets.ModelViewSet):
    queryset = Class.objects.all()
    serializer_class = ClassSerializer

    @action(methods=['get'], detail=False)
    def filter(self, request):
        hashtag_id = request.GET.get('id', None)
        classes = Class.objects.filter(category=hashtag_id)
        serializer = ClassSerializer(classes, many=True)
        data = {
            "class": serializer.data,
            "partner": []
        }
        for i in classes:
            if i.module:
                gym = Module.objects.filter(id=i.module.id)
                partner = ModuleSerializer(gym, many=True)
                data['partner'].append(partner.data)

        return Response(data, 200)


class ImagesViewset(viewsets.ModelViewSet):
    queryset = Images.objects.all()
    serializer_class = ImagesSerializer

    @action(methods=['post'], detail=False)
    def create_date(self, request):
        data = request.data
        group_id = data.get('group', None)
        module_id = data.get('module', None)

        if group_id:
            class_date = ClassDate.objects.create(
                group_id=data['group'],
                status=data['status'],
                finish_date=data['finish_date'],
                start_date=data['start_date'],
                week=data.getlist('week'),

            )
        else:
            class_date = ClassDate.objects.create(
                module_id=module_id,
                status=data['status'],
                finish_date=data['finish_date'],
                start_date=data['start_date'],
                week=data.getlist('week'),

            )
        return Response("created")

    @action(methods=['get'], detail=False)
    def get_date(self, request):
        class_date = ClassDate.objects.all()

        serializer = ClassDateSerializer(class_date, many=True)
        return Response(serializer.data)

    @action(methods=['post'], detail=False)
    def post(self, request):
        image = request.data.getlist('image')
        clas = request.data['class']
        data = json.loads(clas)
        for i in image:
            result = Images.objects.create(
                clas_id=66,
                file=i
            )
        return Response("Create", 201)


class QuestionViewset(viewsets.ModelViewSet):
    queryset = Question.objects.all().order_by("id")
    serializer_class = QuestionSerializer

    @action(methods=['post'], detail=False)
    def post(self, request):
        data = request.data
        serializer = QuestionSerializer(data=data, context=data)
        if serializer.is_valid():
            serializer.is_valid(raise_exception=True)
            serializer.save()
            return Response(serializer.data, 201)
        return Response(serializer.errors)

    @action(methods=['get'], detail=False)
    def get(self, request):
        questions = Question.objects.get(name="Ваш город")
        data = []
        serializer = QuestionMobileSerializer(questions)
        data.append(serializer.data)
        variants = Variant.objects.filter(question__name="С чем ассоциируется данный курс")
        variants_ = Variant.objects.filter(question__name="Выберите свою цель:")
        result = {
            "id": 4,
            "name": "Выберите какие занятия вас интересуют:",
            "variants": []
        }
        for variant in variants:
            result['variants'].append({
                "id": variant.id,
                "name": variant.name,
            })
        data.append(result)
        result_ = {
            "id": 5,
            "name": "Выберите свою цель:",
            "variants": []
        }
        for varian in variants_:
            result_['variants'].append({
                "id": varian.id,
                "name": varian.name,
                "description": varian.description,
                "icon": None
            })
            if varian.icon:
                result_['variants'][-1]['icon'] = varian.icon.url
        data.append(result_)
        return Response(data, status=HTTP_200_OK)


class VariantViewset(viewsets.ModelViewSet):
    queryset = Variant.objects.all()
    serializer_class = VariantSerializer


class LevelViewset(viewsets.ModelViewSet):
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]
    queryset = Level.objects.filter(is_delete=False)
    serializer_class = LevelSerializer

    @action(methods=['get'], detail=False)
    def delete(self, request):
        id = request.GET.get("id", None)
        level = Level.objects.get(id=id)
        level.is_delete = True
        level.save()

        return Response("Delete", status=HTTP_200_OK)

    @action(methods=['get'], detail=False)
    def level_category(self, request):
        class_id = request.GET.get("class_id", None)

        levels = Level.objects.filter(is_delete=False, clas_id=class_id)

        serializer = LevelGetSerializer(levels, many=True)

        return Response(serializer.data, status=200)


class EventsViewset(viewsets.ModelViewSet):
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]
    queryset = Events.objects.all()
    serializer_class = EventsSerializer


class UserInfoViewset(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserInfoSerializer

    @action(methods=['POST'], detail=False)
    def post(self, request):
        data = request.data
        first_name = data.get('first_name', None)
        last_name = data.get('last_name', None)
        birth_date = data.get('birth_date', None)
        gender = data.get('gender', None)
        variant = data.get('variant', None)
        phone_number = data.get('phone_number', None)
        spend = data.get('spend', None)
        amount = data.get('amount', None)
        role = data.get('role', None)
        if User.objects.filter(phone_number=phone_number).exists():
            return Response("phone number already exists", 400)
        else:
            result = User.objects.create(
                first_name=first_name,
                last_name=last_name,
                birth_date=birth_date,
                gender=gender,
                phone_number=phone_number,
                username=phone_number,
                spend=spend,
                amount=amount,
            )
            for i in variant:
                result.variant.add(i)
                result.save()

        token, created = Token.objects.get_or_create(user=result)
        if result.first_name and result.last_name:
            data = {
                'token': token.key,
                "user": {
                    "first_name": result.first_name,
                    "last_name": result.last_name,
                    "phone_number": result.phone_number,
                }
            }
        else:
            data = {
                'token': token.key,
                "user": {
                    "phone_number": result.phone_number,
                }
            }
        return Response(data, 201)


class UserInfoGetViewset(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserInfoGetMobileSerializer

    @action(methods=['POST'], detail=False)
    def post_user_info(self, request):
        data = request.data
        user_id = data.get('id', None)
        first_name = data.get('first_name', None)
        last_name = data.get('last_name', None)
        birth_date = data.get('birth_date', None)
        gender = data.get('gender', None)
        variants = data.get('variants', None)
        job_location = data.get('job_location', None)
        home_location = data.get('home_location', None)

        date_string = birth_date
        datetimet = datetime.strptime(date_string, '%d-%m-%Y')

        birth_date = datetimet.strftime("%Y-%m-%d")
        job_latitude = None
        job_longitude = None
        home_latitude = None
        home_longitude = None
        if job_location:
            job_latitude = job_location[0]
            job_longitude = job_location[1]
        if home_location:
            home_latitude = home_location[0]
            home_longitude = home_location[1]
        result = User.objects.get(id=user_id)
        result.first_name = first_name
        result.last_name = last_name
        result.birth_date = birth_date
        result.gender = gender
        result.is_user = True
        result.role = "student"
        result.job_latitude = job_latitude
        result.job_longitude = job_longitude
        result.home_latitude = home_latitude
        result.home_longitude = home_longitude
        result.save()
        if variants:
            result.variant.clear()
            for i in variants:
                result.variant.add(i)
                # result.save()

        token, created = Token.objects.get_or_create(user=result)
        if result.first_name and result.last_name:
            data = {
                'token': token.key,
                "user": {
                    "first_name": result.first_name,
                    "last_name": result.last_name,
                    "phone_number": result.phone_number,
                    "gender": result.gender,
                    "home_location": result.home_location,
                    "job_location": result.job_location,
                }
            }
        else:
            data = {
                'token': token.key,
                "user": {
                    "first_name": None,
                    "last_name": None,
                    "phone_number": result.phone_number,
                    "gender": result.gender,
                    "home_location": result.home_location,
                    "job_location": result.job_location,
                }
            }
        return Response(data, 201)

    @action(methods=['get'], detail=False)
    def change_status(self, request):
        user_id = request.GET.get("id")
        status = request.GET.get("status")

        user = User.objects.get(id=user_id)
        user.is_user = status
        user.save()
        text = ""
        if status == 'True':
            text = "Mobile User"
        else:
            text = "Web User"
        return Response(f"User changed to {text}!", status=HTTP_200_OK)

    @action(methods=['get'], detail=False)
    def get_mobile(self, request):
        users = User.objects.filter(is_user=True)
        serializer = UserInfoGetMobileSerializer(users, many=True)
        return Response(serializer.data, status=HTTP_200_OK)

    @action(methods=['get'], detail=False)
    def get_web(self, request):
        users = User.objects.filter(is_user=False)
        serializer = UserInfoGetSerializer(users, many=True)
        return Response(serializer.data, status=HTTP_200_OK)


class GroupViewset(viewsets.ModelViewSet):
    queryset = Group.objects.filter(is_delete=False)
    serializer_class = GroupSerializer

    @action(methods=['post'], detail=False)
    def remove_group_from_room(self, request):
        room_id = request.data.get("room_id", None)
        group_id = request.data.get("group_id", None)
        instance_group = Group.objects.get(id=group_id)
        room = Room.objects.get(id=room_id)
        room.group.remove(instance_group)
        room.save()

        return Response("Removed", 200)

    @action(methods=['post'], detail=False)
    def add_group_to_room(self, request):
        room_id = request.data.get("room_id", None)
        group_id = request.data.get("group_id", None)

        room = Room.objects.get(id=room_id)
        room.group.add(group_id)
        room.save()
        return Response("Added", status=201)

    @action(methods=['get'], detail=False)
    def get_group(self, request):
        module_id = request.GET.get("module_id", None)
        groups = Group.objects.filter(module_id=module_id, is_delete=False)
        serializer = GroupGetSerializer(groups, many=True)

        return Response(serializer.data, status=200)


class RecommendationViewset(viewsets.ModelViewSet):
    queryset = Recommendation.objects.all()
    serializer_class = RecommendationSerializer


class RoomViewset(viewsets.ModelViewSet):
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]
    queryset = Room.objects.all()
    serializer_class = RoomSerializer

    @action(methods=['get'], detail=False)
    def timetable(self, request):
        module_id = request.GET.get("module_id", None)
        rooms = Room.objects.filter(module_id=module_id).order_by("id")

        data = []

        for room in rooms:
            group_ids = []
            for gr_id in room.group.all():
                group_ids.append(gr_id.id)
            data.append({
                "id": room.id,
                "name": room.name,
                "groups": []
            })
            groups = Group.objects.all()
            for group in groups:
                if group.id in group_ids:
                    data[-1]['groups'].append({
                        "id": group.id,
                        "group_name": group.name,
                        "group_date": group.group_timetable_date,
                    })
                    data[-1]['groups'][0]['room_id'] = room.id
                    data[-1]['groups'][0]['room_name'] = room.name
        return Response(data, status=HTTP_200_OK)

    @action(methods=['get'], detail=False)
    def filter_timetable(self, request):
        weeks = request.GET.getlist("weeks", None)
        module_id = request.GET.get("module_id", None)
        rooms = Room.objects.filter(module_id=module_id).order_by("id")
        result_weeks = [s for s in weeks[0].split(",") if s.isdigit()]
        data = []

        for room in rooms:
            group_ids = [gr.id for gr in room.group.all()]
            data.append({
                "id": room.id,
                "name": room.name,
                "groups": []
            })

            class_dates = ClassDate.objects.filter(status=2).order_by("start_date")
            class_date_obj = [cld for cld in class_dates if cld.week[0] in result_weeks]
            check_id = []
            for i in class_date_obj:
                gr_date = []
                groups = Group.objects.filter(id=i.group_id)
                date = ClassDate.objects.get(id=i.id)
                gr_date.append({
                    "id": date.id,
                    "room_id": room.id,
                    "room_name": room.name,
                    "week": date.week,
                    "start_date": date.start_date,
                    "finish_date": date.finish_date,
                    "group_id": date.group_id,
                    "group_name": date.group.name,
                    "level_name": date.group.level.name,
                    "class_name": date.group.level.clas.name,
                })
                for group in groups:
                    if data[-1]['groups']:
                        if group.id in group_ids and group.id not in check_id:
                            data[-1]['groups'].append({
                                "id": group.id,
                                "group_name": group.name,
                                "room_id": room.id,
                                "room_name": room.name,
                                "group_date": gr_date,
                                "group_week": group.group_week,
                            })
                            check_id.append(group.id)
                    else:
                        if group.id in group_ids and group.id not in check_id:
                            data[-1]['groups'].append({
                                "id": group.id,
                                "group_name": group.name,
                                "room_id": room.id,
                                "room_name": room.name,
                                "group_date": gr_date,
                                "group_week": group.group_week,

                            })
                            check_id.append(group.id)
        return Response(data, status=HTTP_200_OK)

    @action(methods=['get'], detail=False)
    def filter_timetablea(self, request):
        weeks = request.GET.getlist("weeks", None)
        module_id = request.GET.get("module_id", None)
        rooms = Room.objects.filter(module_id=module_id).order_by("id")
        if len(weeks[0]) == 1:
            result_weeks = tuple(str(weeks[0] + '0'))
        else:
            result_weeks = tuple(s for s in weeks[0].split(","))
        data = []
        for room in rooms:
            data.append({
                "id": room.id,
                "name": room.name,
                "groups": [],
                "disappear_groups": []
            })
            gr_ids = []
            for gr_id in room.group.all():
                gr_ids.append(gr_id.id)
            for grId in Group.objects.filter(is_delete=False, module_id=module_id).exclude(id__in=gr_ids):
                data[-1]["disappear_groups"].append({
                    "id": grId.id,
                    "name": grId.name
                })

            class_date_obj = ClassDate.objects.raw(f'''With classdate as (Select start_date, finish_date, group_id, string_agg(week, ',') as WeekDay
from main_classdate
where status='2' and week in {result_weeks}
group by group_id, start_date, finish_date
order by finish_date-start_date, start_date)
select gr.id,cd.start_date,cd.finish_date, cd.group_id, gr.name, cd.weekday,lv.name as level_name,lv.color as color from classdate as cd
left join main_group as gr on gr.id = cd.group_id
left join main_level as lv on lv.id = gr.level_id
where gr.module_id = {module_id}''')
            for i in class_date_obj:
                if i.group_id in gr_ids:
                    data[-1]['groups'].append({
                        "group_id": i.group_id,
                        "group_name": i.name,
                        "room_id": room.id,
                        "room_name": room.name,
                        "level_name": i.level_name,
                        "color": i.color,
                        "start_date": i.start_date,
                        "finish_date": i.finish_date,
                        "week": i.weekday,
                    })

        return Response(data, status=HTTP_200_OK)
