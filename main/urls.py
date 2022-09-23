from rest_framework import routers
from rest_framework.routers import DefaultRouter
from .views import *


router = DefaultRouter()
# ---------- Partner
router.register('module', ModuleViewset)
router.register('class', ClassViewset)
router.register('level', LevelViewset)
router.register('events', EventsViewset)
router.register('images', ImagesViewset)
router.register('group', GroupViewset)
router.register('room', RoomViewset)
router.register('user', UserInfoViewset)
router.register('recommendation', RecommendationViewset)

# ----------- User

router.register('question', QuestionViewset)
router.register('variant', VariantViewset)
router.register('user', UserInfoViewset)
router.register('user-info', UserInfoGetViewset)
