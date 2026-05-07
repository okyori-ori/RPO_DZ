from abc import ABC, abstractmethod

# ============================================================
# 1. Абстракция (интерфейс) — от которого будут зависеть оба уровня
# ============================================================

class MessageSender(ABC):

    @abstractmethod
    def send(self, message: str) -> None:
        pass


class NotificationService:

    def __init__(self, sender: MessageSender):
        self._sender = sender
    def notify(self, message: str) -> None:

        print(f"[Сервис] Отправка уведомления...")
        self._sender.send(message)
        print(f"[Сервис] Уведомление отправлено.\n")



class EmailSender(MessageSender):

    def send(self, message: str) -> None:
        print(f"[Email] Отправка по email: {message}")


class SmsSender(MessageSender):

    def send(self, message: str) -> None:
        print(f"[SMS] Отправка SMS: {message}")


class PushSender(MessageSender):

    def send(self, message: str) -> None:
        print(f"[Push] Отправка push-уведомления: {message}")



class MockSender(MessageSender):
    ""
    def send(self, message: str) -> None:
        print(f"[Mock] (Тестовая заглушка) Был бы отправлен текст: {message}")




if __name__ == "__main__":
    print("=" * 50)
    print("Демонстрация DIP (Dependency Inversion Principle)")
    print("=" * 50)


    print("\n1. Настройка: используем EmailSender")
    email_sender = EmailSender()
    notification_service = NotificationService(email_sender)
    notification_service.notify("Ваш заказ подтверждён!")


    print("2. Переключение на SMSSender")
    sms_sender = SmsSender()
    notification_service = NotificationService(sms_sender)
    notification_service.notify("Код подтверждения: 123456")


    print("3. Переключение на PushSender")
    push_sender = PushSender()
    notification_service = NotificationService(push_sender)
    notification_service.notify("Новое сообщение от пользователя")


    print("4. Тестовый режим (MockSender)")
    mock_sender = MockSender()
    notification_service = NotificationService(mock_sender)
    notification_service.notify("Тестовое уведомление — реальная отправка не происходит")


    print("\n" + "=" * 50)
    print("ВЫВОД:")
    print("- NotificationService не зависит от Email/SMS/Push/Mock.")
    print("- Все конкретные отправители реализуют интерфейс MessageSender.")
    print("- Легко добавлять новые типы уведомлений (Telegram, Viber, ...).")
    print("- Легко писать тесты (подставляем MockSender).")
    print("=" * 50)