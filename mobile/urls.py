from rest_framework import routers
from rest_framework.routers import DefaultRouter
from .views import *


router = DefaultRouter()

router.register('course', CourseViewSet, basename='CourseViewSet')
router.register('review', ReviewViewSet, basename='ReviewViewSet')
router.register('wishlist', WishlistViewSet, basename='WishlistViewSet')
router.register('module-mobile', ModuleViewSet, basename='ModuleViewSet')
