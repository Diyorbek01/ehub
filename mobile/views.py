from datetime import datetime
from django.db.models import Q
from django.shortcuts import render
from django.utils import timezone
from rest_framework import viewsets, authentication, permissions
from rest_framework.generics import RetrieveUpdateDestroyAPIView
from rest_framework.status import *
from rest_framework.response import Response
from main.models import *
# Create your views here.
from rest_framework.decorators import action

from main.serializers import ClassSerializer
from subscription.models import Wishlist, Subscription
from mobile.serializers import ReviewSerializer, ReviewGetSerializer, ModuleMobileSerializer, ModuleMobileGetSerializer, \
    WishListSerializer
from main.models import Review


class CourseViewSet(viewsets.ModelViewSet):
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]

    @action(methods=["get"], detail=False)
    def get_category(self, request):
        question = Question.objects.filter(status="partner", name="С чем ассоциируется данный курс")
        data = []
        if question.exists():
            variants = Variant.objects.filter(question=question.last().id)
            for variant in variants:
                number_class = Class.objects.filter(category_id=variant.id).count()

                data.append({
                    "id": variant.id,
                    "name": variant.name,
                    "amount": number_class
                })
            return Response(data, status=HTTP_200_OK)
        else:
            return Response("Question doesn't exist", status=HTTP_400_BAD_REQUEST)

    @action(methods=["post"], detail=False)
    def filter_module_category(self, request):
        category = request.data.get('category')
        modules = Module.objects.filter(~Q(status="delete"))
        serializer = []
        for module in modules:
            categories = []
            for cat in module.facilities.all():
                categories.append(cat.id)
            for category_id in category:
                if category_id in categories:
                    serializer.append({
                        "id": module.id,
                        "legal_name": module.legal_name,
                        "logo": None,
                        "description": module.description,
                        "rating": module.rating,
                        "number_reviews": module.number_reviews
                    })
                    if module.logo:
                        serializer[-1]['logo'] = module.logo.url
        return Response(serializer, status=HTTP_200_OK)

    @action(methods=["get"], detail=False)
    def get_group(self, request):
        class_id = request.GET.get("class_id", None)
        level = Level.objects.filter(clas=class_id)
        data = []
        for i in level:
            data.append({
                "level_id": i.id,
                "level_name": i.name,
                "groups": i.groups,
            })
        return Response(data, status=HTTP_200_OK)

    @action(methods=["get"], detail=False)
    def get_my_courses(self, request):
        user_id = request.GET.get('user_id', None)
        subcriptions = Subscription.objects.filter(user_id=user_id, is_active=True)
        data = []
        for sub in subcriptions:
            data.append({
                "subscription_id": sub.id,
                "module_name": sub.group.level.clas.module.legal_name,
                "level_duration": sub.group.level.duration,
                "level_name": sub.group.level.name,
            })
        return Response(data, status=HTTP_200_OK)

    @action(methods=["get"], detail=False)
    def get_level(self, request):
        group_id = request.GET.get("group_id", None)
        group = Group.objects.get(id=group_id)
        data = []
        if group:
            data.append({
                "level_id": group.level.id,
                "level_name": group.level.name,
                "course_name": group.level.clas.name,
                "module_name": group.level.clas.module.legal_name,
                "students_number": group.current_students_number,
                "price": group.level.price,
            })
        return Response(data, status=HTTP_200_OK)

    @action(methods=["get"], detail=False)
    def get_courses(self, request):
        variant_id = request.GET.get("category_id", None)
        module_id = request.GET.get("module_id", None)
        if variant_id:
            classes = Class.objects.filter(category_id=variant_id)
        elif module_id:
            classes = Class.objects.filter(module_id=module_id)
        data = []
        for clas in classes:
            data.append({
                "module_id": clas.module.id,
                "module_name": clas.module.legal_name,
                "course_id": clas.id,
                "course_name": clas.name,
                "course_images": clas.images,
                "opening_date": clas.module.opening_hours,
                "rating": clas.rating,
                "number_reviews": clas.number_reviews,
                "reviews": clas.reviews,
            })
        return Response(data, status=HTTP_200_OK)

    @action(methods=["get"], detail=False)
    def get_course_details(self, request):
        class_id = request.GET.get("id", None)
        clas = Class.objects.get(id=class_id)
        data = [{
            "module_id": clas.module.id,
            "module_name": clas.module.legal_name,
            "course_id": clas.id,
            "course_name": clas.name,
            "course_description": clas.description,
            "opening_date": clas.module.opening_hours,
            "address": clas.module.location,
            "rating": clas.rating,
            "number_reviews": clas.number_reviews,
            "reviews": clas.reviews,
            "image": clas.images,
        }]
        return Response(data, status=HTTP_200_OK)


class ReviewViewSet(viewsets.ModelViewSet):
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]
    queryset = Review.objects.all()
    serializer_class = ReviewSerializer

    @action(methods=["get"], detail=False)
    def get(self, request):

        queryset = Review.objects.all()
        serializer = ReviewGetSerializer(queryset, many=True)
        return Response(serializer.data, status=HTTP_200_OK)

    @action(methods=["get"], detail=False)
    def filter_reviews(self, request):
        module_id = request.GET.get("module_id", None)
        class_id = request.GET.get("class_id", None)
        level_id = request.GET.get("level_id", None)
        event_id = request.GET.get("event_id", None)
        data = []
        if module_id:
            queryset = Review.objects.filter(module_id=module_id)
            for review in queryset:
                data.append({
                    "id": review.id,
                    "user_full_name": f"{review.user.first_name} {review.user.last_name}",
                    "module_id": review.module.id,
                    "comment": review.comment,
                    "rate": review.rate,
                    "create_at": timezone.localtime(review.create_at),
                })
            return Response(data, status=HTTP_200_OK)
        elif class_id:
            queryset = Review.objects.filter(clas_id=class_id)
            for review in queryset:
                data.append({
                    "id": review.id,
                    "user_full_name": f"{review.user.first_name} {review.user.last_name}",
                    "class_id": review.clas.id,
                    "comment": review.comment,
                    "rate": review.rate,
                    "create_at": timezone.localtime(review.create_at),

                })
            return Response(data, status=HTTP_200_OK)
        elif level_id:
            queryset = Review.objects.filter(level_id=level_id)
            for review in queryset:
                data.append({
                    "id": review.id,
                    "user_full_name": f"{review.user.first_name} {review.user.last_name}",
                    "level_id": review.level.id,
                    "comment": review.comment,
                    "rate": review.rate,
                    "create_at": timezone.localtime(review.create_at),

                })
            return Response(data, status=HTTP_200_OK)
        elif event_id:
            queryset = Review.objects.filter(level_id=level_id)
            for review in queryset:
                data.append({
                    "id": review.id,
                    "user_full_name": f"{review.user.first_name} {review.user.last_name}",
                    "event_id": review.event.id,
                    "comment": review.comment,
                    "rate": review.rate,
                    "create_at": timezone.localtime(review.create_at),

                })
            return Response(data, status=HTTP_200_OK)

        return Response("Reviewes not found", status=HTTP_400_BAD_REQUEST)

    @action(methods=["post"], detail=False)
    def post(self, request):
        data = request.data
        user_id = request.data.get('user', None)

        if user_id:
            subscription = Subscription.objects.filter(user=user_id)
            if subscription.exists():
                serializer = ReviewSerializer(data=data)
                if serializer.is_valid():
                    serializer.is_valid(raise_exception=True)
                    serializer.save()
                    return Response(serializer.data, status=HTTP_201_CREATED)
                return Response(serializer.errors, status=HTTP_400_BAD_REQUEST)
            else:
                return Response("этот пользователь не имеет права голоса", status=HTTP_400_BAD_REQUEST)


class WishlistViewSet(viewsets.ModelViewSet):
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]
    queryset = Wishlist.objects.all()
    serializer_class = WishListSerializer

    @action(methods=['post'], detail=False)
    def post(self, request):
        user_id = request.data.get("user", None)
        module_id = request.data.get("module", None)
        class_id = request.data.get("clas", None)
        if class_id:
            wishlist = Wishlist.objects.filter(user_id=user_id, clas_id=class_id)
            if wishlist.exists():
                instance_wishlist = wishlist.last()
                if instance_wishlist.is_like == True:
                    instance_wishlist.is_like = False
                    instance_wishlist.save()
                elif instance_wishlist.is_like == False:
                    instance_wishlist.is_like = True
                    instance_wishlist.save()
            else:
                result = Wishlist.objects.create(
                    clas_id=class_id,
                    user_id=user_id,
                )
            return Response("Created", 201)
        elif module_id:
            wishlist = Wishlist.objects.filter(user_id=user_id, module_id=module_id)
            if wishlist.exists():
                instance_wishlist = wishlist.last()
                if instance_wishlist.is_like == True:
                    instance_wishlist.is_like = False
                    instance_wishlist.save()
                elif instance_wishlist.is_like == False:
                    instance_wishlist.is_like = True
                    instance_wishlist.save()
            else:
                result = Wishlist.objects.create(
                    module_id=module_id,
                    user_id=user_id,
                )
            return Response("Created", 201)
        return Response("Created", 201)

    @action(methods=['get'], detail=False)
    def get(self, request):
        user_id = request.GET.get("user_id", None)
        wishlists = Wishlist.objects.filter(user_id=user_id, is_like=True)
        data = []
        for wishlist in wishlists:
            if wishlist.module:
                if wishlist.module.logo:
                    data.append({
                        "wishlist_id": wishlist.id,
                        "module_id": wishlist.module.id,
                        "module_name": wishlist.module.legal_name,
                        "module_description": wishlist.module.description,
                        "module_logo": wishlist.module.logo.url,
                        "module_rating": wishlist.module.rating,
                        "module_number_reviews": wishlist.module.number_reviews,
                        "status": "module"
                    })
                else:
                    data.append({
                        "wishlist_id": wishlist.id,
                        "module_id": wishlist.module.id,
                        "module_name": wishlist.module.legal_name,
                        "module_description": wishlist.module.description,
                        "module_logo": None,
                        "module_rating": wishlist.module.rating,
                        "module_number_reviews": wishlist.module.number_reviews,
                        "status": "module"
                    })
            elif wishlist.clas:
                data.append({
                    "wishlist_id": wishlist.id,
                    "course_id": wishlist.clas.id,
                    "course_name": wishlist.clas.name,
                    "module_id": wishlist.clas.module.id,
                    "module_name": wishlist.clas.module.legal_name,
                    "opening_hours": wishlist.clas.module.opening_hours,
                    "course_rating": wishlist.clas.rating,
                    "course_number_reviews": wishlist.clas.number_reviews,
                    "status": "course"
                })

        return Response(data, status=HTTP_200_OK)

    @action(methods=['get'], detail=False)
    def check_wishlist(self, request):
        user_id = request.GET.get("user_id", None)
        module_id = request.GET.get("module_id", None)
        class_id = request.GET.get("class_id", None)

        if module_id:
            if Wishlist.objects.filter(user_id=user_id, module_id=module_id, is_like=True).exists():
                return Response("Module exists", status=202)
            else:
                return Response("Module doesn't exist", status=200)
        elif class_id:
            if Wishlist.objects.filter(user_id=user_id, clas_id=class_id, is_like=True).exists():
                return Response("Class exists", status=202)
            else:
                return Response("Class doesn't exist", status=200)


class ModuleViewSet(viewsets.ModelViewSet):
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]
    queryset = Module.objects.all()
    serializer_class = ModuleMobileSerializer

    @action(methods=['get'], detail=False)
    def get_details(self, request):
        id = request.GET.get("id", None)
        modules = Module.objects.get(id=id)
        serializer = ModuleMobileGetSerializer(modules)
        return Response(serializer.data, status=HTTP_200_OK)

    @action(methods=['get'], detail=False)
    def get_courses(self, request):
        modules = Module.objects.filter(~Q(status="delete"))
        data = []
        for module in modules:
            for clas in Class.objects.filter(module_id=module.id):
                data.append({
                    "module_id": module.id,
                    "module_name": module.legal_name,
                    "course_id": clas.id,
                    "course_name": clas.name,
                    "course_description": clas.description,
                    "opening_date": module.opening_hours,
                    "address": module.location,
                    "rating": clas.rating,
                    "number_reviews": clas.number_reviews,
                    "reviews": clas.reviews,
                    "image": clas.images,
                })
        return Response(data, status=HTTP_200_OK)

    @action(methods=['get'], detail=False)
    def user_location(self, request):
        user_id = request.GET.get("user_id", None)
        user = User.objects.get(id=user_id)
        data = []
        data.append(dict(
            job_location=user.job_location,
            home_location=user.home_location))
        return Response(data, status=200)

    @action(methods=['post'], detail=False)
    def update_location(self, request):
        user_id = request.data.get("user_id", None)
        job_location = request.data.get("job_location", None)
        home_location = request.data.get("home_location", None)

        user = User.objects.get(id=user_id)
        user.job_latitude = None
        user.job_longitude = None
        user.home_latitude = None
        user.home_longitude = None
        user.save()
        if job_location:
            user.job_latitude = job_location[0]
            user.job_longitude = job_location[1]
            user.save()
        if home_location:
            user.home_latitude = home_location[0]
            user.home_longitude = home_location[1]
            user.save()
        data = []
        data.append(dict(
            job_location=user.job_location,
            home_location=user.home_location))
        return Response(data)

    @action(methods=['get'], detail=False)
    def delete_location(self, request):
        user_id = request.GET.get("user_id", None)
        type = request.GET.get("type", None)
        type_location = type.split(',')[0]
        type_location2 = None
        try:
            type_location2 = type.split(',')[1]
        except:
            type_location2 = None

        user = User.objects.get(id=user_id)
        if type_location == 'job_location' or type_location2 == "job_location":
            user.job_latitude = None
            user.job_longitude = None
            user.save()

        if type_location == 'home_location' or type_location2 == 'home_location':
            user.home_latitude = None
            user.home_longitude = None
            user.save()

        data = []
        data.append(dict(
            job_location=user.job_location,
            home_location=user.home_location))
        return Response(data)

    @action(methods=['post'], detail=False)
    def update_user_info(self, request):
        user_id = request.data.get("user_id", None)
        first_name = request.data.get("first_name", None)
        last_name = request.data.get("last_name", None)
        birth_date = request.data.get("birth_date", None)
        gender = request.data.get("gender", None)

        date_string = birth_date
        datetimet = datetime.strptime(date_string, '%d-%m-%Y')

        birth_date = datetimet.strftime("%Y-%m-%d")

        user = User.objects.get(id=user_id)
        user.first_name = first_name
        user.last_name = last_name
        user.birth_date = birth_date
        user.gender = gender
        user.is_user = True
        user.save()

        data = [dict(
            id=user.id,
            first_name=user.first_name,
            last_name=user.last_name,
            birth_date=user.birth_date,
            gender=user.gender
        )]
        return Response(data, status=200)
