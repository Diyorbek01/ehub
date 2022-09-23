from django.contrib import admin

# Register your models here.
from subscription.models import Invoice

admin.site.register(Invoice)