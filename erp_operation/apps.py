from django.apps import AppConfig


class ErpOperationConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'erp_operation'

    def ready(self):
        print("Start schedular ...")
        from . import updater
        updater.start()
