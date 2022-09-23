import binascii
import os

from django.db import models

# Create your models here.
from main.models import Class, User, Group, Module


class Subscription(models.Model):
    NEW_STATUS = (('new', 'new'),
                  ("old", 'old'),
                  )

    group = models.ForeignKey(Group, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    start_date = models.DateField(null=True, blank=True)
    finish_date = models.DateField(null=True, blank=True)
    is_free = models.BooleanField(default=False)
    is_in_group = models.BooleanField(default=True)
    is_active = models.BooleanField(default=True)
    is_active_user = models.BooleanField(default=True)
    is_new = models.CharField(max_length=50, choices=NEW_STATUS, default="new")
    is_paid = models.BooleanField(default=False)
    attendance = models.IntegerField(default=0)
    create_at = models.DateTimeField(auto_now_add=True)
    update_at = models.DateTimeField(auto_now=True)


    def __str__(self):
        return f"G-{self.group.name}: U-{self.user.first_name}"

class Operation(models.Model):
    STATUS = (
        (1, "come"),
        (2, "not come"),
        (3, "no reason"),
        (4, "start attendance"),
    )
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    subscription = models.ForeignKey(Subscription, on_delete=models.CASCADE, null=True, blank=True)
    group = models.ForeignKey(Group, on_delete=models.CASCADE, null=True, blank=True)
    status = models.CharField(max_length=20, choices=STATUS, default=1)
    is_free = models.BooleanField(default=False)
    is_debt = models.BooleanField(default=False)
    create_at = models.DateTimeField(auto_now_add=True)
    update_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.user.first_name} -- {self.group.name}"

class Wishlist(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    module = models.ForeignKey(Module, on_delete=models.CASCADE, null=True, blank=True)
    clas = models.ForeignKey(Class, on_delete=models.CASCADE, null=True, blank=True)
    is_like = models.BooleanField(default=True)
    create_at = models.DateTimeField(auto_now_add=True)
    update_at = models.DateTimeField(auto_now=True)


class Invoice(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    module = models.ForeignKey(Module, on_delete=models.CASCADE, null=True, blank=True)
    subscription = models.ForeignKey(Subscription, on_delete=models.CASCADE, null=True, blank=True)
    amount = models.BigIntegerField(null=True)
    card_number = models.BigIntegerField(null=True)
    create_at = models.DateTimeField(auto_now_add=True)
    update_at = models.DateTimeField(auto_now=True)
