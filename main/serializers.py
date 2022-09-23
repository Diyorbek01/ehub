from rest_framework import serializers
from rest_framework.authtoken.models import Token

from main.models import *
from main.models import Review


class ModuleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Module
        fields = ['id', 'legal_name', 'logo', "images", 'contact_name', 'phone_number', 'description', 'location',
                  'create_at', "address",
                  "opening_hours", 'facilities', 'status', "rating", "number_reviews"]
        # fields = "__all__"


class ModulessSerializer(serializers.ModelSerializer):
    class Meta:
        model = Module
        fields = '__all__'


class QuestionMobileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Question
        fields = ["id", 'name', 'variants', ]


class QuestionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Question
        fields = ['id', 'name', 'status', 'variants', 'create_at']

    def create(self, validated_data):
        result = Question.objects.create(**validated_data)
        variants = self.context.get('variant')
        for i in variants:
            Variant.objects.create(
                **i,
                question_id=result.id
            )
        return result


class VariantSerializer(serializers.ModelSerializer):
    question = QuestionSerializer(read_only=True)

    class Meta:
        model = Variant
        fields = '__all__'


class VariantsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Variant
        fields = '__all__'


class RoomSerializer(serializers.ModelSerializer):
    class Meta:
        model = Room
        fields = '__all__'


class ClassSerializer(serializers.ModelSerializer):
    category = VariantsSerializer()

    class Meta:
        model = Class
        # fields = '__all__'
        fields = ['id', 'module', 'name', "category", 'images', 'description',
                  'create_at', "events", "levels", "rating", "number_reviews"]


class ImagesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Images
        fields = '__all__'


class ClassDateSerializer(serializers.ModelSerializer):
    class Meta:
        model = ClassDate
        fields = '__all__'


class UserInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'


class LevelSerializer(serializers.ModelSerializer):
    class Meta:
        model = Level
        fields = '__all__'


class LevelGetSerializer(serializers.ModelSerializer):
    class Meta:
        model = Level
        fields = ['id', "name"]


class EventsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Events
        fields = '__all__'


class UserInfoGetSerializer(serializers.ModelSerializer):
    variant = VariantsSerializer(many=True, read_only=True)

    class Meta:
        model = User
        fields = "__all__"


class GroupSerializer(serializers.ModelSerializer):
    class Meta:
        model = Group
        fields = '__all__'

class GroupGetSerializer(serializers.ModelSerializer):
    class Meta:
        model = Group
        fields = ["id", "name"]


class RecommendationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Recommendation
        fields = '__all__'
