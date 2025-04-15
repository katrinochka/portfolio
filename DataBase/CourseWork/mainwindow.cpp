#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "QMessageBox"
#include <QFormLayout>
#include <QLabel>
#include <QDebug>
#include <QSqlError>
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    connect(ui->btnConnect,SIGNAL(clicked(bool)),this, SLOT(dbconnect()));
}
MainWindow::~MainWindow()
{
    if( dbconn.isOpen())
        dbconn.close();
    delete ui;
}
void MainWindow::on_btnHello_clicked()
{
    QMessageBox::about(this,"info","Hello!");
}

void MainWindow::dbconnect()
{
    QMessageBox::about(this,"info","я тута");
    if(!dbconn.isOpen())
    {
        // Если соединение не открыто, то вывести список доступных драйверов БД
        // (вывод в поле teResult, метод append добавляет строки).
        ui->teResult->append("SQL drivers:");
        ui->teResult->append(QSqlDatabase::drivers().join(","));
        // Создать глобальную переменную для установки соединения с БД
        dbconn=QSqlDatabase::addDatabase("QPSQL");
        // Установить параметры соединения: имя БД, адрес хоста, логин и пароль
        //пользователя, порт (если отличается от стандартного)
        dbconn.setDatabaseName("StaffDepartment");
        dbconn.setHostName("localhost");
        dbconn.setUserName("postgres");
        dbconn.setPassword("13579");
        // Открыть соединениe и результат вывести в окно вывода
        if( dbconn.open() )
            ui->teResult->append("Connect is open...");
        else
        {
            ui->teResult->append("Error of connect:");
            ui->teResult->append(dbconn.lastError().text());
        }
    }
    else
        // Если соединение уже открыто, то сообщить об этом
        ui->teResult->append("Connect is already open...");
}
