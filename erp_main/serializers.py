from rest_framework import serializers
from rest_framework.authtoken.models import Token

from erp_main.models import Achievment
from main.models import ClassDate, Question, Variant
from main.serializers import UserInfoSerializer, GroupSerializer
from subscription.models import *


class ClassPostSerializer(serializers.ModelSerializer):
    class Meta:
        model = Class
        fields = "__all__"


class ClasGetSerializer(serializers.ModelSerializer):
    class Meta:
        model = Class
        fields = ['id', 'name']


class ClasGetDetailsSerializer(serializers.ModelSerializer):
    category_id = serializers.SerializerMethodField()

    class Meta:
        model = Class
        fields = ['id', 'name', 'description', 'create_at', "category_id", "category_name", 'class_levels', "images"]

    def get_category_id(self, obj):
        return obj.category.id


class VariantGetSerializer(serializers.ModelSerializer):
    class Meta:
        model = Variant
        fields = ['id', 'name']


class GroupGetSerializer(serializers.ModelSerializer):
    level_name = serializers.SerializerMethodField()
    level_id = serializers.SerializerMethodField()

    class Meta:
        model = Group
        fields = ['id', 'name', "level_name", "level_id"]

    def get_level_name(self, obj):
        return obj.level.name

    def get_level_id(self, obj):
        return obj.level.id


class GroupGetDetailsSerializer(serializers.ModelSerializer):
    level_name = serializers.SerializerMethodField()
    class_name = serializers.SerializerMethodField()

    class Meta:
        model = Group
        fields = ['id', 'name', 'create_at', 'current_students_number', 'limit', 'status',
                  'number_of_lessons_per_month', 'type_group', 'duration', "level_name", 'class_name', "group_date"
                  ]


    def get_level_name(self, obj):
        return obj.level.name

    def get_class_name(self, obj):
        return obj.level.clas.name


class StaffSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = "__all__"


class StaffGetSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ["id", "first_name", "last_name", "middle_name"]


class StudentSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = "__all__"


class StudentGetSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ["id", "first_name", "last_name", "phone_number", "is_user"]


class StudentDetailsSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ["id", "first_name", "last_name", "address", "gender", "birth_date", "phone_number", "create_at",
                  "status", "photo", "is_user"]
