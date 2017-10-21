CONFIG += qt
QT += qml quick
TEMPLATE = lib
TARGET = qmlogre

macx {
    OGREDIR = $$(OGRE_HOME)
    isEmpty(OGREDIR) {
        error(QmlOgre needs Ogre to be built. Please set the environment variable OGRE_HOME pointing to your Ogre root directory.)
    } else {
        message(Using Ogre libraries in $$OGREDIR)
        INCLUDEPATH += $$OGREDIR/include/OGRE
        INCLUDEPATH += $$OGREDIR/include/OGRE/RenderSystems/GL
        QMAKE_LFLAGS += -F$$OGREDIR/lib/release
        LIBS += -framework Ogre

        BOOSTDIR = $$OGREDIR/boost_1_42
        !isEmpty(BOOSTDIR) {
            INCLUDEPATH += $$BOOSTDIR
#            LIBS += -L$$BOOSTDIR/lib -lboost_date_time-xgcc40-mt-1_42 -lboost_thread-xgcc40-mt-1_42
        }
    }
} else:unix {
    CONFIG += link_pkgconfig
    PKGCONFIG += OGRE
} else:win32 {
    DEFINES += QMLOGRE_DLL
    OGREDIR = $$(OGRE_HOME)
    isEmpty(OGREDIR) {
        error(QmlOgre needs Ogre to be built. Please set the environment variable OGRE_HOME pointing to your Ogre root directory.)
    } else {
        message(Using Ogre libraries in $$OGREDIR)
        INCLUDEPATH += $$OGREDIR/include/OGRE
        INCLUDEPATH += $$OGREDIR/include/OGRE/RenderSystems/GL
        CONFIG(release, debug|release) {
            LIBS += -L$$OGREDIR/lib/release -lOgreMain -lRenderSystem_GL
        } else {
            LIBS += -L$$OGREDIR/lib/debug -lOgreMain_d -lRenderSystem_GL_d
        }
        LIBS += -L$$OGREDIR/lib -L$$OGREDIR/lib/OGRE -lOpengl32
    }
}

UI_DIR = ./.ui
OBJECTS_DIR = ./.obj
MOC_DIR = ./.moc


SOURCES += ogreitem.cpp \
    ogrenode.cpp \
    ogrecamerawrapper.cpp \
    ogreengine.cpp

HEADERS += \
    ogreitem.h \
    ogrenode.h \
    ogrecamerawrapper.h \
    ogreengine.h \
    qmlogre_common.h

# Copy all headers to build folder
Headers.path = $$OUT_PWD/include
Headers.files = $$files(*.h)
INSTALLS += Headers
