#pragma once

#include <QObject>
#include <QVariant>

class SettingsBase
{
public:
	static QVariant readEntry(const QString & key, const QVariant defaultValue = QVariant());
	static void writeEntry(const QString & key, const QVariant & value);
};

class Settings : public QObject, public SettingsBase
{
	Q_OBJECT

public:
	Settings(QObject * parent = 0);

	Q_INVOKABLE static QString getUsername();
	Q_INVOKABLE static void setUsername(const QString & username);
	Q_INVOKABLE static QString getPassword();
	Q_INVOKABLE static void setPassword(const QString & password);
};
