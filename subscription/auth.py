import random
import string
import requests
import json

from django.contrib.auth import authenticate, login
from django.db.models import Q
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.authtoken.models import Token
from rest_framework.status import HTTP_404_NOT_FOUND, HTTP_400_BAD_REQUEST

from main.models import User, UserToken, Module


def send_sms(phone_number, code):
    url = "http://91.204.239.44/broker-api/send"

    payload = json.dumps({
        "messages": [
            {
                "recipient": phone_number,
                "message-id": "abc000000001",
                "sms": {
                    "originator": "3700",
                    "content": {
                        "text": f"Sizning tasdiqlash kodingiz: {code}"
                    }
                }
            }
        ]
    })
    headers = {
        'Authorization': 'Basic YXJjaGk6RlptNnU2NlQ4dg==',
        'Content-Type': 'application/json'
    }

    response = requests.request("POST", url, headers=headers, data=payload)
    data = dict(
        response=response.text,
        phone_number=phone_number
    )
    return data


def random_string(digit_count):
    str1 = ''.join((random.choice(string.digits) for x in range(digit_count)))

    sam_list = list(str1)  # it converts the string to list.
    random.shuffle(sam_list)  # It uses a random.shuffle() function to shuffle the string.
    final_string = ''.join(sam_list)
    return final_string


@api_view(['POST'])
def login(request):
    phone_number = request.data.get("phone_number", None)
    password = request.data.get("password", None)

    if Module.objects.filter(phone_number=phone_number, password=password).exists() and password != None:
        module = Module.objects.filter(phone_number=phone_number, password=password).last()
        try:
            user, created = User.objects.get_or_create(
                phone_number=phone_number,
                status="partner",
                role="staff"
            )
        except:
            user = User.objects.filter(role="staff", phone_number=phone_number).last()
        token, created = Token.objects.get_or_create(user_id=user.id)
        data = [{
            "token": token.key,
            "user": {
                "id": module.id,
                "name": module.legal_name,
                "logo": None,
                "description": module.description,
                "user_id": user.id,
                "user_full_name": f'{user.first_name} {user.last_name}'
            }
        }]

        if module.logo:
            data[-1]['user']['logo'] = module.logo.url
        return Response(data, 200)
    elif User.objects.filter(role="staff", phone_number=phone_number, password=password).exists() and password != None:
        user = User.objects.filter(role="staff", phone_number=phone_number, password=password).last()
        token, created = Token.objects.get_or_create(user_id=user.id)
        if user.module:
            data = [{
                "token": token.key,
                "user": {
                    "id": user.module.id,
                    "name": user.module.legal_name,
                    "logo": None,
                    "description": user.module.description,
                    "user_id": user.id,
                    "user_full_name": f'{user.first_name} {user.last_name}'
                }
            }]
            if user.module.logo:
                data[-1]['user']['logo'] = user.module.logo.url
        else:
            data = [{
                "token": token.key,
                "user": {
                    "id": None,
                    "name": None,
                    "logo": None,
                    "description": None,
                    "user_id": user.id,
                    "user_full_name": f'{user.first_name} {user.last_name}'
                }
            }]

        return Response(data, 200)
    else:
        return Response("Логин или пароль неверный", status=400)


@api_view(['POST'])
def chek_sms(request):
    code = request.data['code']
    token = UserToken.objects.all().last().token
    if code == token:
        return Response("Success", 200)
    else:
        return Response("Неверный смс-код", 400)


@api_view(['POST'])
def check_otp(request):
    code = request.data['code']
    data = UserToken.objects.all().last()
    token = data.token
    phone_number = data.phone_number
    print(token, code)
    if code == token:

        if Module.objects.filter(phone_number=phone_number).exists():
            try:
                user, created = User.objects.get_or_create(
                    phone_number=phone_number,
                    status="partner",
                    role="staff",
                )
            except:
                user = User.objects.filter(role="staff", phone_number=phone_number).last()
            token, created = Token.objects.get_or_create(user_id=user.id)
            data.delete()
            module = Module.objects.filter(phone_number=phone_number).last()
            user_ = User.objects.filter(role="staff", module_id=module.id, phone_number=phone_number)
            if user_.exists():
                user_instance = user_.last()
                data = {
                    'token': token.key,
                    "user": {
                        "id": module.id,
                        "module_name": module.legal_name,
                        "phone_number": phone_number,
                        "user_id": user_instance.id,
                        "user_full_name": f'{user_instance.first_name} {user_instance.last_name}',
                        "is_module": True
                    }
                }
            else:
                data = {
                    'token': token.key,
                    "user": {
                        "id": module.id,
                        "module_name": module.legal_name,
                        "phone_number": phone_number,
                        "user_id": None,
                        "user_full_name": None,
                        "is_module": True
                    }
                }
            return Response(data, status=200)
        elif User.objects.filter(role="staff", phone_number=phone_number).exists():
            try:
                user, created = User.objects.get_or_create(
                    phone_number=phone_number,
                    status="partner",
                    role="staff",
                )
            except:
                user = User.objects.filter(role="staff", phone_number=phone_number).last()
            token, created = Token.objects.get_or_create(user_id=user.id)
            data.delete()
            user = User.objects.filter(role="staff", phone_number=phone_number).last()

            data = {
                'token': token.key,
                "user": {
                    "id": user.module.id,
                    "module_name": user.module.legal_name,
                    "phone_number": phone_number,
                    "user_id": user.id,
                    "user_full_name": f'{user.first_name} {user.last_name}',
                    "is_module": False
                }
            }
            return Response(data, status=200)
        else:
            return Response("В этом телефонном номере нет модуля", status=HTTP_400_BAD_REQUEST)

    else:
        return Response('Неверный смс-код', status=400)


@api_view(['POST'])
def send_sms_register(request):
    phone_number = request.data['phone_number']
    user_instance = User.objects.filter(phone_number=phone_number, role="staff")
    module_instance = Module.objects.filter(~Q(status="delete"), phone_number=phone_number)
    if user_instance.exists() or module_instance.exists():
        code = random_string(4)
        result = send_sms(phone_number, code)
        data = UserToken.objects.create(
            token=code,
            phone_number=phone_number
        )
        return Response(result, 200)
    else:
        return Response("Телефон недоступен", 400)


@api_view(['POST'])
def update_password(request):
    user_id = request.data.get("user_id", None)
    module_id = request.data.get("module_id", None)
    new_password = request.data.get("new_password", None)
    phone_number = request.data.get("phone_number", None)

    if module_id:
        if Module.objects.filter(id=module_id).exists():
            module = Module.objects.get(id=user_id)
            module.password = new_password
            module.save()
            user = User.objects.filter(role="staff", module_id=module.id).last()
            token, created = Token.objects.get_or_create(user_id=user)
            data = [{
                "token": token.key,
                "user": {
                    "id": module.id,
                    "name": module.legal_name,
                    "logo": None,
                    "description": module.description
                }
            }]
            if module.logo:
                data[-1]['user']['logo'] = module.logo.url
            return Response(data)
    elif User.objects.filter(role="staff", id=user_id).exists():
        user = User.objects.filter(role="staff", phone_number=phone_number).last()
        user.password = new_password
        user.save()
        token, created = Token.objects.get_or_create(user_id=user.id)
        data = [{
            "token": token.key,
            "user": {
                "id": user.module.id,
                "name": user.module.legal_name,
                "logo": None,
                "description": user.module.description,
                "user_id": user.id,
                "user_full_name": f'{user.first_name} {user.last_name}',
            }
        }]
        if user.module.logo:
            data[-1]['user']['logo'] = user.module.logo.url
        return Response(data)
    else:
        return Response("Пользователь не найден", 400)
