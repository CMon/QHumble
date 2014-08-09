#include <humblebundleapi.h>

#include "settings.h"

#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char *argv[])
{
	QApplication app(argc, argv);

//	HumbleBundleAPI hbApi;
//	while (!hbApi.isLoggedIn()) {
//		app.processEvents();
//	}
//	hbApi.updateOrderList();

	Settings settings;
	QQmlApplicationEngine engine;

	engine.rootContext()->setContextProperty("Settings", &settings);

	engine.load(QUrl(QStringLiteral("qrc:///qml/main.qml")));

	return app.exec();
}
