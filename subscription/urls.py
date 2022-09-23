from rest_framework import routers
from rest_framework.routers import DefaultRouter
from .views import *


router = DefaultRouter()

router.register('subscription', SubscriptionViewset)
router.register('subscription-list', SubscriptionGetViewset)
router.register('operation', OperationViewset)
