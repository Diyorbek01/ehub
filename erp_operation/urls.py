from rest_framework import routers
from rest_framework.routers import DefaultRouter
from .views import *


router = DefaultRouter()

router.register('achievment-erp', AchievmentViewset)
router.register('group-erp', GroupViewset)

