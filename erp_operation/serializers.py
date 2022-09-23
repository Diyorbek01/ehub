from rest_framework import serializers

from erp_main.models import Achievment
from main.models import Level


class AchievmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Achievment
        fields = "__all__"

class LevelSerializer(serializers.ModelSerializer):
    class Meta:
        model = Level
        fields = "__all__"
