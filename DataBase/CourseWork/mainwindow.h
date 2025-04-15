#ifndef MAINWINDOW_H
#define MAINWINDOW_H
#include <QMainWindow>
#include <QPushButton>
#include <QLineEdit>
#include <QSqlDatabase>

namespace Ui {
class MainWindow;
}
class MainWindow : public QMainWindow
{
    Q_OBJECT
public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();
private slots:
    void on_btnHello_clicked();

private:
    QSqlDatabase dbconn;
    Ui::MainWindow *ui;
    QPushButton *btnHi;
    QLineEdit *lnFio;

public slots:
    void dbconnect();
};
#endif // MAINWINDOW_H
