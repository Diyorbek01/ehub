# Generated by Django 4.0.4 on 2022-08-02 10:25

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('main', '0006_alter_user_module'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='module',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='main.module'),
        ),
    ]
