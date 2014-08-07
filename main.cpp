#include <humblebundleapi.h>

#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char *argv[])
{
	QApplication app(argc, argv);

	HumbleBundleAPI hbApi;
	while (!hbApi.isLoggedIn()) {
		app.processEvents();
	}
	hbApi.updateOrderList();

	QQmlApplicationEngine engine;
	engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

	return app.exec();
}
