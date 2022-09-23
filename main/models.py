from django.contrib.auth.models import AbstractUser
from django.db import models
from django.db.models import Avg
from multiselectfield import MultiSelectField

# Create your models here.
from rest_framework.authtoken.models import Token

# from mobile.models import Review
from erp_main.models import Achievment


class Question(models.Model):
    STATUS = (("partner", 'Partner'),
              ("user", 'User')
              )
    status = models.CharField(max_length=20, choices=STATUS, default="user")
    name = models.CharField(max_length=300)
    create_at = models.DateTimeField(auto_now_add=True)
    update_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

    @property
    def variants(self):
        variants = Variant.objects.filter(question_id=self.id)
        data = []
        for i in variants:
            data.append({
                "id": i.id,
                "name": i.name,
                "create_at": i.create_at,
            })
        return data


class Variant(models.Model):
    question = models.ForeignKey(Question, on_delete=models.CASCADE, null=True, blank=True)
    name = models.CharField(max_length=300)
    description = models.TextField(null=True, blank=True)
    icon = models.ImageField(upload_to="icons/", null=True, blank=True)
    create_at = models.DateTimeField(auto_now_add=True)
    update_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name


class Module(models.Model):
    STATUS = (('potential', 'Potential'),
              ('active', 'Active'),
              ('delete', 'Delete'),
              )
    is_active = models.BooleanField(default=True)
    established_year = models.DateField(null=True, blank=True)
    inn = models.BigIntegerField(null=True, blank=True)
    bank_account = models.BigIntegerField(null=True, blank=True)
    bank_name = models.CharField(max_length=300, null=True, blank=True)
    director = models.CharField(max_length=300, null=True, blank=True)
    parent_firm = models.ForeignKey('self', on_delete=models.CASCADE, null=True, blank=True)
    email = models.CharField(max_length=100, null=True, blank=True)
    facilities = models.ManyToManyField(Variant, blank=True)
    legal_name = models.CharField(max_length=200)
    password = models.CharField(max_length=200, default="123")
    contact_name = models.CharField(max_length=200)
    status = models.CharField(max_length=30, choices=STATUS, default="potential")
    phone_number = models.CharField(max_length=20, unique=True)
    description = models.TextField(blank=True, null=True)
    logo = models.ImageField(upload_to='logo', blank=True, null=True)
    qr_code = models.ImageField(upload_to='qr_code/', null=True, blank=True)
    address = models.CharField(max_length=300, null=True)
    location1 = models.CharField(max_length=300, blank=True, null=True)
    location2 = models.CharField(max_length=300, blank=True, null=True)
    create_at = models.DateTimeField(auto_now_add=True)
    update_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.legal_name

    @property
    def rating(self):
        result = Review.objects.filter(module=self).aggregate(avarage=Avg("rate"))
        if result['avarage']:
            return round(result['avarage'], 1)
        else:
            return 0

    @property
    def images(self):
        result = Images.objects.filter(module_id=self.id)
        data = []
        for i in result:
            try:
                data.append(i.file.url)
            except:
                data.append(None)
        return data

    @property
    def number_reviews(self):
        result = Review.objects.filter(module=self).count()
        return result

    @property
    def reviews(self):
        result = Review.objects.filter(module=self).order_by("create_at")[:3]
        data = []
        for i in result:
            data.append({
                "id": i.id,
                "user_full_name": f"{i.user.first_name} {i.user.last_name}",
                "comment": i.comment,
                "rate": i.rate,
                "create_at": i.create_at,
            })
        return data

    @property
    def location(self):
        return [self.location1, self.location2]

    @property
    def opening_hours(self):
        result = ClassDate.objects.filter(module_id=self.id, status=1)
        data = []

        for i in result:
            data.append({
                "id": i.id,
                "start_date": i.start_date,
                "finish_date": i.finish_date,
                "week": i.week,
                "create_at": i.create_at,
            })
        return data


class User(AbstractUser):
    GENDER = (("male", "Male"),
              ("female", "Female"))
    STATUS = (('potential', 'Potential'),
              ('active', 'Active'),
              ('partner', 'Partner'),
              ('delete', 'Delete'),
              )
    ROLE = (('staff', 'staff'),
            ('student', 'student'),
            )
    SALARY_TYPE = (('fixed', 'fixed'),
                   ('not_fixed', 'not fixed'),
                   ('not_given', 'not given'),
                   )
    module = models.ForeignKey(Module, on_delete=models.CASCADE, null=True)
    first_name = models.CharField(max_length=40, blank=True, null=True)
    last_name = models.CharField(max_length=40, blank=True, null=True)
    middle_name = models.CharField(max_length=40, blank=True, null=True)
    achievments = models.ManyToManyField(Achievment, blank=True)
    email = models.EmailField(blank=True, null=True)
    salary_type = models.CharField(max_length=40, choices=SALARY_TYPE, default="not_given")
    salary = models.BigIntegerField(null=True)
    passport_file = models.FileField(upload_to="passports/", null=True)
    photo = models.ImageField(upload_to="profile/", null=True, blank=True)
    is_delete = models.BooleanField(default=False)
    birth_date = models.DateField(blank=True, null=True)
    username = models.CharField(max_length=50, null=True, blank=True, unique=True)
    gender = models.CharField(max_length=25, choices=GENDER, blank=True, null=True)
    status = models.CharField(max_length=25, choices=STATUS, default='potential')
    role = models.CharField(max_length=25, choices=ROLE, default='student')
    variant = models.ManyToManyField(Variant, blank=True)
    phone_number = models.CharField(max_length=25, unique=True)
    address = models.CharField(max_length=350, null=True)
    spend = models.FloatField(blank=True, null=True)
    amount = models.FloatField(blank=True, null=True)
    job_latitude = models.FloatField(blank=True, null=True)
    job_longitude = models.FloatField(blank=True, null=True)
    home_latitude = models.FloatField(blank=True, null=True)
    home_longitude = models.FloatField(blank=True, null=True)
    is_user = models.BooleanField(default=False)
    create_at = models.DateTimeField(auto_now_add=True)
    update_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.phone_number

    @property
    def job_location(self):
        result = [self.job_latitude, self.job_longitude]
        return result

    @property
    def home_location(self):
        result = [self.home_latitude, self.home_longitude]
        return result


class Class(models.Model):
    module = models.ForeignKey(Module, on_delete=models.CASCADE, blank=True, null=True)
    category = models.ForeignKey(Variant, on_delete=models.CASCADE, blank=True, null=True)
    name = models.CharField(max_length=100)
    description = models.TextField(blank=True, null=True)
    create_at = models.DateTimeField(auto_now_add=True)
    update_at = models.DateTimeField(auto_now=True)
    is_delete = models.BooleanField(default=False)

    def __str__(self):
        return self.name

    @property
    def rating(self):
        result = Review.objects.filter(clas=self).aggregate(avarage=Avg("rate"))
        if result['avarage']:
            return round(result['avarage'], 1)
        else:
            return 0

    @property
    def number_reviews(self):
        result = Review.objects.filter(clas=self).count()
        return result

    @property
    def reviews(self):
        result = Review.objects.filter(clas=self).order_by("create_at")[:3]
        data = []
        for i in result:
            data.append({
                "id": i.id,
                "user_full_name": f"{i.user.first_name} {i.user.last_name}",
                "comment": i.comment,
                "rate": i.rate,
                "create_at": i.create_at,
            })
        return data

    @property
    def images(self):
        result = Images.objects.filter(clas_id=self.id)
        data = []
        for i in result:
            try:
                data.append(i.file.url)
            except:
                data.append(None)
        return data

    @property
    def events(self):
        events = Events.objects.filter(clas_id=self.id, is_delete=False)
        data = []
        for event in events:
            data.append({
                "id": event.id,
                'status': event.status,
                'name': event.name,
                'description': event.description,
                'date': event.date,
                'clas_id': event.clas.id
            })
        return data

    @property
    def levels(self):
        levels = Level.objects.filter(clas_id=self.id, is_delete=False)
        result = []
        for level in levels:
            result.append({
                "id": level.id,
                'status': level.status,
                'name': level.name,
                'duration': level.duration,
                'number_of_lessons': level.number_of_lessons,
                'price': level.price,
                'clas_id': level.clas.id,
                "groups": level.groups
            })
        return result

    @property
    def class_levels(self):
        levels = Level.objects.filter(clas_id=self.id, is_delete=False)
        result = []
        for level in levels:
            result.append({
                "id": level.id,
                'status': level.status,
                'name': level.name,
                'color': level.color,
                'duration': level.duration,
                'number_of_lessons': level.number_of_lessons,
                'price': level.price,
                'create_at': level.create_at,
                'lesson_price': int(level.price) / int(level.number_of_lessons),
            })
        return result

    @property
    def category_name(self):

        return self.category.name


class Level(models.Model):
    STATUS = (("old", 'old'),
              ("young", 'young'),
              ("all", 'all'),
              )
    clas = models.ForeignKey(Class, on_delete=models.CASCADE)
    name = models.CharField(max_length=150)
    duration = models.IntegerField()
    is_delete = models.BooleanField(default=False)
    status = models.CharField(max_length=50, choices=STATUS)
    number_of_lessons = models.IntegerField()
    price = models.IntegerField()
    color = models.CharField(max_length=30, null=True, blank=True)
    create_at = models.DateTimeField(auto_now_add=True)
    update_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

    @property
    def rating(self):
        result = Review.objects.filter(level=self).aggregate(avarage=Avg("rate"))
        if result['avarage']:
            return round(result['avarage'], 1)
        else:
            return 0

    @property
    def number_reviews(self):
        result = Review.objects.filter(level=self).count()
        return result

    @property
    def reviews(self):
        result = Review.objects.filter(level=self).order_by("create_at")[:3]
        data = []
        for i in result:
            data.append({
                "id": i.id,
                "user_full_name": f"{i.user.first_name} {i.user.last_name}",
                "comment": i.comment,
                "rate": i.rate,
                "create_at": i.create_at,
            })
        return data

    @property
    def groups(self):
        groups = Group.objects.filter(level_id=self.id, is_delete=False)
        data = []
        for i in groups:
            data.append({
                "id": i.id,
                "name": i.name,
                "status": i.status,
                "type": i.type_group,
                "current_students_number": i.current_students_number,
                "limit": i.limit,
                "duration": i.duration,
                "create_at": i.create_at,
                "level_date": i.group_date
            })

        return data


class Events(models.Model):
    NEW_STATUS = (('new', 'new'),
                  ("old", 'old'),
                  )

    STATUS = (('Через день', 'Через день'),
              ("1-2 раза в неделю", '1-2 раза в неделю'),
              ("1-3 раза в месяц", '1-3 раза в месяц'),
              ("Раз в 2 месяца", 'Раз в 2 месяца'),
              ("Другая частота проведения", 'Другая частота проведения'),
              )
    clas = models.ForeignKey(Class, on_delete=models.CASCADE)
    name = models.CharField(max_length=150)
    description = models.TextField()
    date = models.DateField()
    is_delete = models.BooleanField(default=False)
    is_new = models.CharField(max_length=50, choices=NEW_STATUS, default="new")
    status = models.CharField(max_length=50, choices=STATUS)
    create_at = models.DateTimeField(auto_now_add=True)
    update_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

    @property
    def rating(self):
        result = Review.objects.filter(event=self).aggregate(avarage=Avg("rate"))
        if result['avarage']:
            return round(result['avarage'], 1)
        else:
            return 0

    @property
    def number_reviews(self):
        result = Review.objects.filter(event=self).count()
        return result

    @property
    def reviews(self):
        result = Review.objects.filter(event=self).order_by("create_at")[:3]
        data = []
        for i in result:
            data.append({
                "id": i.id,
                "user_full_name": f"{i.user.first_name} {i.user.last_name}",
                "comment": i.comment,
                "rate": i.rate,
                "create_at": i.create_at,
            })
        return data


class Images(models.Model):
    clas = models.ForeignKey(Class, on_delete=models.CASCADE, null=True, blank=True)
    module = models.ForeignKey(Module, on_delete=models.CASCADE, null=True, blank=True)
    file = models.ImageField(upload_to='module')
    create_at = models.DateTimeField(auto_now_add=True)
    update_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        if self.clas:
            return self.clas.name
        else:
            return self.module.legal_name


class UserToken(models.Model):
    phone_number = models.CharField(max_length=20, null=True, blank=True)
    token = models.CharField(max_length=10, null=True, blank=True)


class Review(models.Model):
    NEW_STATUS = (('new', 'new'),
                  ("old", 'old'),
                  )

    user = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True)
    module = models.ForeignKey(Module, on_delete=models.CASCADE, null=True, blank=True)
    clas = models.ForeignKey(Class, on_delete=models.CASCADE, null=True, blank=True)
    level = models.ForeignKey(Level, on_delete=models.CASCADE, null=True, blank=True)
    event = models.ForeignKey(Events, on_delete=models.CASCADE, null=True, blank=True)
    comment = models.TextField(null=True, blank=True)
    is_new = models.CharField(max_length=50, choices=NEW_STATUS, default="new")
    rate = models.IntegerField(null=True, blank=True, default=0)
    create_at = models.DateTimeField(auto_now_add=True)
    update_at = models.DateTimeField(auto_now=True)


class Recommendation(models.Model):
    STATUS = (
        ("new", "new"),
        ("old", "old")
    )
    name = models.CharField(max_length=200)
    phone_number = models.CharField(max_length=20)
    create_at = models.DateTimeField(auto_now_add=True)


class Group(models.Model):
    STATUS = (
        ("full", "full"),
        ("open", "open"),
        ("waiting", "waiting")
    )

    TYPE = (('group', 'Group'),
            ("individual", 'Individual')
            )
    module = models.ForeignKey(Module, on_delete=models.CASCADE)
    level = models.ForeignKey(Level, on_delete=models.CASCADE)
    clas = models.ForeignKey(Class, on_delete=models.CASCADE, null=True)
    # teacher = models.ForeignKey(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=150)
    is_delete = models.BooleanField(default=False)
    current_students_number = models.IntegerField(blank=True, null=True)
    limit = models.IntegerField(blank=True, null=True)
    number_of_lessons_per_month = models.IntegerField(blank=True, null=True)
    status = models.CharField(max_length=20, choices=STATUS, blank=True, null=True)
    type_group = models.CharField(max_length=20, choices=TYPE, blank=True, null=True)
    duration = models.IntegerField(null=True, blank=True)
    # teachers_share = models.IntegerField(null=True, blank=True)
    create_at = models.DateTimeField(auto_now_add=True)
    update_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

    @property
    def group_date(self):
        result = ClassDate.objects.filter(status=2, group_id=self.id)
        data = []
        for i in result:
            data.append({
                "id": i.id,
                "week": i.week,
                "start_date": i.start_date,
                "finish_date": i.finish_date,

            })
        return data

    @property
    def group_date_mobile(self):
        result = ClassDate.objects.filter(status=2, group_id=self.id)
        data = []
        for i in result:
            data.append({
                "id": i.id,
                "week": int(i.week[0]),
                "start_date": i.start_date,
                "finish_date": i.finish_date,

            })
        return data

    @property
    def group_timetable_date(self):
        result = ClassDate.objects.filter(status=2, group_id=self.id)
        data = []
        for i in result:
            data.append({
                "week": i.week,
                "start_date": i.start_date,
                "finish_date": i.finish_date,
                "group_id": self.id,
                "group_name": self.name,
                "level_name": self.level.name,
                "class_name": self.level.clas.name,
            })
        return data

    @property
    def group_time(self):
        result = ClassDate.objects.filter(status=2, group_id=self.id)
        data = []
        for i in result:
            data.append({
                "start_date": i.start_date,
                "finish_date": i.finish_date,
            })
        return data

    @property
    def group_week(self):
        result = ClassDate.objects.filter(status=2, group_id=self.id)
        data = []
        for i in result:
            data.append(i.week)
        return data


class Room(models.Model):
    module = models.ForeignKey(Module, on_delete=models.CASCADE)
    name = models.CharField(max_length=150)
    group = models.ManyToManyField(Group, blank=True)
    is_delete = models.BooleanField(default=False)
    create_at = models.DateTimeField(auto_now_add=True)
    update_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name


class ClassDate(models.Model):
    DAY_WEEK = ((1, 'Mon'),
                (2, 'Tue'),
                (3, 'Wed'),
                (4, 'Thu'),
                (5, 'Fri'),
                (6, 'Sat'),
                (7, 'Sun'))
    STATUS = ((1, 'Opening date'),
              (2, 'Group date')
              )
    group = models.ForeignKey(Group, on_delete=models.CASCADE, blank=True, null=True)
    module = models.ForeignKey(Module, on_delete=models.CASCADE, blank=True, null=True)
    week = MultiSelectField(choices=DAY_WEEK,
                            max_choices=7,
                            max_length=25, blank=True, null=True)
    status = models.CharField(max_length=50, choices=STATUS)
    start_date = models.TimeField(blank=True, null=True)
    finish_date = models.TimeField(blank=True, null=True)
    create_at = models.DateTimeField(auto_now_add=True)
    update_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.status


class StudentReason(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    reason = models.ForeignKey(Variant, on_delete=models.CASCADE)
    group = models.ForeignKey(Group, on_delete=models.CASCADE, null=True)
    event = models.ForeignKey(Events, on_delete=models.CASCADE, null=True)

    def __str__(self):
        return self.reason.name
