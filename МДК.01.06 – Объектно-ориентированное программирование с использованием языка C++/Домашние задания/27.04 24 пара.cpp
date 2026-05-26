#include <iostream>
using namespace std;

class Notification{
    public:
        virtual void send() = 0;
};

class EmailNotification : public Notification{
    public:
        void send() override{
            cout << "Notification sended on your email!" << endl;
        }
};

class SMSNotification : public Notification{
    public:
        void send() override{
            cout << "Notification sended in SMS!" << endl;
        }
};

class PushNotification : public Notification{
    public:
        void send() override{
            cout << "Push-notification sended on your phone!" << endl;
        }
};

int main(){
    Notification* email = new EmailNotification();
    email->send();

    Notification* sms = new SMSNotification();
    sms->send();

    Notification* push = new PushNotification();
    push->send();

    delete email;
    delete sms;
    delete push;
}