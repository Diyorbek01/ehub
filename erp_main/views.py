import json
import operator

from dateutil.relativedelta import relativedelta
from django.db.models import Q
from django.shortcuts import render

# Create your views here.
from django.utils.timezone import now
from geopy.distance import geodesic
from rest_framework import viewsets, authentication, permissions
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.status import *

from erp_main.models import Achievment
from erp_main.serializers import ClassPostSerializer, ClasGetSerializer, ClasGetDetailsSerializer, GroupGetSerializer, \
    GroupGetDetailsSerializer, VariantGetSerializer, StaffSerializer, StaffGetSerializer, \
    StudentGetSerializer, StudentDetailsSerializer
from main.models import Class, Group, Question, Variant, Module, User, ClassDate, Images
from main.serializers import GroupSerializer, VariantSerializer
from subscription.models import Subscription


class ClassViewset(viewsets.ModelViewSet):
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]
    queryset = Class.objects.filter(is_delete=False)
    serializer_class = ClassPostSerializer

    @action(methods=['post'], detail=False)
    def post(self, request):
        clas = request.data.get('data', None)
        image = request.FILES.getlist("image", None)
        data = json.loads(clas)
        class_instance = Class.objects.create(
            **data
        )
        for i in image:
            Images.objects.create(
                clas=class_instance,
                file=i
            )
        return Response({"message":"Created","id":class_instance.id}, status=HTTP_201_CREATED)

    @action(methods=['get'], detail=False)
    def delete(self, request):
        id = request.GET.get("id", None)
        clas = Class.objects.get(id=id)
        clas.is_delete = True
        clas.save()
        # module = Module.objects.get(id=id)
        # module.phone_number="+998932429264"
        # module.save()

        return Response("Delete", status=HTTP_200_OK)

    @action(methods=['get'], detail=False)
    def get_nearby_modules(self, request):
        lat = request.GET.get("lat", None)
        long = request.GET.get("long", None)
        radius = request.GET.get("radius", None)
        if radius == None:
            radius = 5
        all_location = []
        modules = Module.objects.filter(~Q(status="delete"))
        origin = (float(lat), float(long))  # (latitude, longitude) don't confuse
        for module in modules:
            dist = (float(module.location1), float(module.location2))
            distance = geodesic(origin, dist).km
            if distance < float(radius):
                all_location.append({
                    "id": module.id,
                    "name": module.legal_name,
                    "distance": round(distance, 3),
                    "logo": None,
                    "lat": module.location1,
                    "long": module.location2
                })
                if module.logo:
                    all_location[-1]['logo'] = module.logo.url
        newlist = sorted(all_location, key=lambda d: d['distance'])
        return Response(newlist)

    @action(methods=['get'], detail=False)
    def get_nearby_modules_details(self, request):
        lat = request.GET.get("lat", None)
        long = request.GET.get("long", None)
        radius = request.GET.get("radius", None)
        if radius == None:
            radius = 5
        all_location = []
        modules = Module.objects.filter(~Q(status="delete"))
        origin = (float(lat), float(long))  # (latitude, longitude) don't confuse
        for module in modules:
            dist = (float(module.location1), float(module.location2))
            distance = geodesic(origin, dist).km
            if distance < float(radius):
                all_location.append({
                    "id": module.id,
                    "legal_name": module.legal_name,
                    "distance": round(distance, 3),
                    "logo": None,
                    "images": module.images,
                    "description": module.description,
                    "phone_number": module.phone_number,
                    "number_reviews": module.number_reviews,
                    "rating": module.rating,
                    "contact_name": module.contact_name,
                    "location": module.location,
                    "facilities": [x for x in module.facilities.all()],
                    "reviews": module.reviews,
                })
                if module.logo:
                    all_location[-1]['logo'] = module.logo.url
        newlist = sorted(all_location, key=lambda d: d['distance'])
        return Response(newlist)

    @action(methods=['get'], detail=False)
    def get_nearby_modules_address(self, request):
        user_id = request.GET.get("user_id", None)
        is_home = request.GET.get("is_home", None)
        radius = request.GET.get("radius", None)
        user = User.objects.get(id=user_id)
        if is_home == "true":
            lat = user.home_latitude
            long = user.home_longitude
        else:
            lat = user.job_latitude
            long = user.job_longitude

        all_location = []
        try:
            modules = Module.objects.filter(~Q(status="delete"))
            origin = (float(lat), float(long))  # (latitude, longitude) don't confuse
            for module in modules:
                dist = (float(module.location1), float(module.location2))
                distance = geodesic(origin, dist).km
                if distance < float(radius):
                    all_location.append({
                        "id": module.id,
                        "legal_name": module.legal_name,
                        "distance": round(distance, 3),
                        "logo": None,
                        "lat": module.location1,
                        "long": module.location2
                    })
                    if module.logo:
                        all_location[-1]['logo'] = module.logo.url
            newlist = sorted(all_location, key=lambda d: d['distance'])
            return Response(newlist)
        except:
            return Response({"message": "Modules not found"})

    @action(methods=['get'], detail=False)
    def get(self, request):
        module_id = request.GET.get("id", None)
        classes = Class.objects.filter(module_id=module_id, is_delete=False).order_by("-id")
        serializer = ClasGetSerializer(classes, many=True)
        return Response(serializer.data, status=HTTP_200_OK)

    @action(methods=['get'], detail=False)
    def get_details(self, request):
        class_id = request.GET.get("id", None)

        clas = Class.objects.get(id=class_id, is_delete=False)
        serializer = ClasGetDetailsSerializer(clas)
        return Response(serializer.data, status=HTTP_200_OK)

    @action(methods=['post'], detail=False)
    def update_class(self, request):
        clas = request.data.get('data', None)
        image = request.FILES.getlist("image", None)
        data = json.loads(clas)
        class_instance = Class.objects.get(id=data.get("id", None))
        class_instance.name = data.get("name", None)
        class_instance.module_id = data.get("module", None)
        class_instance.category_id = data.get("category", None)
        class_instance.description = data.get("description", None)

        class_instance.save()

        images = Images.objects.filter(clas_id=class_instance.id).delete()
        for i in image:
            Images.objects.create(
                clas=class_instance,
                file=i
            )
        return Response("Created", status=HTTP_201_CREATED)

    @action(methods=['get'], detail=False)
    def get_category(self, request):
        question = Question.objects.get(status='partner', name="С чем ассоциируется данный курс")
        variant = Variant.objects.filter(question_id=question.id)
        serializer = VariantGetSerializer(variant, many=True)
        return Response(serializer.data, status=HTTP_200_OK)


class StaffViewset(viewsets.ModelViewSet):
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]
    queryset = User.objects.filter(is_delete=False)
    serializer_class = StaffSerializer

    @action(methods=['get'], detail=False)
    def get(self, request):
        users = User.objects.filter(is_delete=False, role="staff")
        serializer = StaffGetSerializer(users, many=True)

        return Response(serializer.data)

    @action(methods=['get'], detail=False)
    def delete(self, request):
        id = request.GET.get("id", None)
        user = User.objects.get(id=id)
        user.is_delete = True
        user.save()
        return Response("Delete", status=HTTP_200_OK)


class StudentViewset(viewsets.ModelViewSet):
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]
    queryset = User.objects.filter(is_delete=False, role="student")
    serializer_class = StaffSerializer

    @action(methods=['get'], detail=False)
    def delete(self, request):
        id = request.GET.get("id", None)
        user = User.objects.get(id=id)
        user.is_delete = True
        user.save()
        return Response("Delete", status=HTTP_200_OK)

    @action(methods=['get'], detail=False)
    def get(self, request):
        module_id = request.GET.get("module_id", None)

        students = User.objects.filter(is_delete=False, module_id=module_id, role="student")
        serializer = StudentGetSerializer(students, many=True)

        return Response(serializer.data, status=HTTP_200_OK)

    @action(methods=['get'], detail=False)
    def get_details(self, request):
        id = request.GET.get("id", None)

        students = User.objects.get(id=id)
        serializer = StudentDetailsSerializer(students)

        return Response(serializer.data, status=HTTP_200_OK)
