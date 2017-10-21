#ifndef QMLOGRE_COMMON_H
#define QMLOGRE_COMMON_H

#ifdef QMLOGRE_DLL
#define QMLOGRE_EXPORT __declspec( dllexport )
#else
#define QMLOGRE_EXPORT __declspec( dllimport )
#endif

#endif// QMLOGRE_COMMON_H
