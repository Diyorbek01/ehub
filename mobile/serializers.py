from rest_framework import serializers
from rest_framework.authtoken.models import Token

from main.models import *
from main.models import Review
from main.serializers import UserInfoSerializer, ModuleSerializer, ClassSerializer, LevelSerializer, EventsSerializer, \
    VariantSerializer, VariantsSerializer
from subscription.models import Wishlist


class ModuleMobileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Module
        fields = ['id', 'legal_name', 'logo', 'description', "rating", "number_reviews"]
        # fields = "__all__"


class WishListSerializer(serializers.ModelSerializer):
    class Meta:
        model = Wishlist
        fields = "__all__"



class ModuleMobileGetSerializer(serializers.ModelSerializer):
    facilities = VariantsSerializer(many=True)

    class Meta:
        model = Module
        fields = ['id', 'legal_name', 'logo', "images", 'description', "rating", "number_reviews", 'phone_number',
                  'contact_name', 'location', 'facilities', "reviews"
                  ]


class ReviewGetSerializer(serializers.ModelSerializer):
    user = UserInfoSerializer()
    module = ModuleSerializer()
    clas = ClassSerializer()
    level = LevelSerializer()
    event = EventsSerializer()

    class Meta:
        model = Review
        fields = '__all__'


class ReviewSerializer(serializers.ModelSerializer):
    class Meta:
        model = Review
        fields = '__all__'


class QuestionMobileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Question
        fields = ['id', 'name', 'create_at']


class VariantMobileSerializer(serializers.ModelSerializer):
    question = QuestionMobileSerializer(read_only=True)

    class Meta:
        model = Variant
        fields = '__all__'


class UserInfoGetMobileSerializer(serializers.ModelSerializer):
    variant = VariantMobileSerializer(many=True, read_only=True)

    class Meta:
        model = User
        fields = ["id", 'first_name', 'last_name', 'birth_date', 'gender', 'status',
                  'variant', 'phone_number', 'job_location', 'home_location']


class QuestionMobileVariantSerializer(serializers.ModelSerializer):
    class Meta:
        model = Question
        fields = ['id', 'name', 'variants']
