from django.test import TestCase

# Create your tests here.
from datetime import datetime, timedelta

now = datetime.now()
mon = now.weekday()
tue = now.weekday() + 1
wed = now.weekday() + 2
thu = now.weekday() + 3
fri = now.weekday() + 4
sat = now.weekday() + 5
sun = now.weekday() + 6
monday = now - timedelta(days=tue)
print(monday)
