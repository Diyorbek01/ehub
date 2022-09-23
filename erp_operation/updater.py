from urllib import request

import pytz
import tzlocal
from apscheduler.schedulers.background import BackgroundScheduler

from erp_operation.views import CronJob


def start():
    schedular = BackgroundScheduler(timezone='Asia/Tashkent')
    cron = CronJob()

    schedular.add_job(cron.get, "cron", hour='01-13', minute='10', kwargs={'request': request})

    schedular.start()
