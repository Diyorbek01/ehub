from rest_framework import serializers
from rest_framework.authtoken.models import Token

from main.serializers import UserInfoSerializer, GroupSerializer
from subscription.models import *


class SubscriptionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Subscription
        fields = "__all__"


class SubscriptionGetSerializer(serializers.ModelSerializer):
    group = GroupSerializer()
    user = UserInfoSerializer()

    class Meta:
        model = Subscription
        fields = "__all__"


class OperationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Operation
        fields = "__all__"
