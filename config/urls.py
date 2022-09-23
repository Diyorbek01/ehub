"""config URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from django.conf.urls.static import static
from django.conf import settings

from erp_operation.views import CronJob
from main import auth
from subscription import auth as _auth
from main.urls import router
from erp_main.urls import router as erp_main_router
from erp_operation.urls import router as erp_op_router
from subscription.urls import router as s_router
from mobile.urls import router as m_router
from subscription import views
from main import views as _views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/v1/', include(router.urls)),
    path('api/v1/', include(s_router.urls)),
    path('api/v1/', include(m_router.urls)),
    path('api/v1/', include(erp_main_router.urls)),
    path('api/v1/', include(erp_op_router.urls)),
    path('__debug__/', include('debug_toolbar.urls')),

    # -------------- mobile ---------------

    path("download/<int:id>/", _views.download_image, name="download"),

    path('api/v1/api-auth/admin_login/', auth.login),
    path('api/v1/api-auth/register/', auth.register),
    path('api/v1/api-auth/check_sms/', auth.chek_sms),
    path('api/v1/api-auth/send_sms/', auth.send_sms_register),

    # --------- web --------------------

    path('api/v1/api-web-auth/register/', _auth.check_otp),
    path('api/v1/api-web-auth/check_sms/', _auth.chek_sms),
    path('api/v1/api-web-auth/send_sms/', _auth.send_sms_register),
    path('api/v1/api-web-auth/login/', _auth.login),
    path('api/v1/api-web-auth/reset-password/', _auth.update_password),


    path('api/v1/cron/', CronJob.as_view()),

    path('api/payme/', include('paymeuz.urls'))

]
urlpatterns += static(settings.KEY_URL, document_root=settings.KEY_ROOT)
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
