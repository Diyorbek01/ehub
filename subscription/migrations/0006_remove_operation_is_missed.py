# Generated by Django 4.0.4 on 2022-08-04 05:36

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('subscription', '0005_alter_operation_status'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='operation',
            name='is_missed',
        ),
    ]
