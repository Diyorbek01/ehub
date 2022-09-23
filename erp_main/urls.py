from rest_framework import routers
from rest_framework.routers import DefaultRouter
from .views import *


router = DefaultRouter()

router.register('class-erp', ClassViewset)
router.register('staff-erp', StaffViewset)
router.register('student-erp', StudentViewset)
