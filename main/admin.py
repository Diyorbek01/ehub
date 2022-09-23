from django.contrib import admin

# Register your models here.
from main.models import *


class ModuleAdmin(admin.ModelAdmin):
    list_display = ['id', 'legal_name', 'phone_number']


class ClassAdmin(admin.ModelAdmin):
    list_display = ['id', 'name']


class UserAdmin(admin.ModelAdmin):
    list_display = ['id', 'first_name', 'last_name']


class VariantAdmin(admin.ModelAdmin):
    list_display = ['id', 'name']


class QuestionAdmin(admin.ModelAdmin):
    list_display = ['id', 'name']


class GroupAdmin(admin.ModelAdmin):
    list_display = ['id', 'name', 'type_group']


class LevelAdmin(admin.ModelAdmin):
    list_display = ['id', 'name']


class RoomAdmin(admin.ModelAdmin):
    list_display = ['id', 'name']


class ReviewAdmin(admin.ModelAdmin):
    list_display = ['id', 'user', "comment"]


class EventsAdmin(admin.ModelAdmin):
    list_display = ['id', 'name']


admin.site.register(Module, ModuleAdmin)
admin.site.register(Class, ClassAdmin)
admin.site.register(Images)
admin.site.register(ClassDate)
admin.site.register(User, UserAdmin)
admin.site.register(Variant, VariantAdmin)
admin.site.register(Question, QuestionAdmin)
admin.site.register(Group, GroupAdmin)
admin.site.register(Level, LevelAdmin)
admin.site.register(Room, RoomAdmin)
admin.site.register(Review, ReviewAdmin)
admin.site.register(Events, EventsAdmin)
