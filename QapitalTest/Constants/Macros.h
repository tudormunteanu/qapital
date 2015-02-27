//
//  Macros.h
//  fnac ibeacon
//
//  Created by Tudor Munteanu on 20/11/14.
//  Copyright (c) 2014 http://mowowstudios.com. All rights reserved.
//

#ifndef fnac_ibeacon_Macros_h
#define fnac_ibeacon_Macros_h

/*
 Two parameters possible, optional.
 
 @param source - the object which will be casted (most common case will be 'self', which is default)
 @param variable - variable name, default is weakSelf or strongSelf
 
 Examples:
 weakify() - you have weakened weakSelf variable
 weakify(self) - the same as weakify()
 weakify(self, myWeak) - you have weakened myWeak variable
 strongify(weakSelf) - you have strongified strongSelf variable, taken from weakSelf
 
 source: https://gist.github.com/literator/9184313
 */

#define weakify(...) _callQualifierX(weak, ##__VA_ARGS__)
#define strongify(...) _callQualifierX(strong, ##__VA_ARGS__)

#pragma mark - Helpers

#define _callQualifierX(qualifier, ...) \
_callX(, \
##__VA_ARGS__, \
_##qualifier##ify2(qualifier, __VA_ARGS__), \
_##qualifier##ify1(qualifier, __VA_ARGS__), \
_##qualifier##ify0(qualifier, __VA_ARGS__)) \

#define _weakify0(qualifier, ...) _weakify1(qualifier, self)
#define _weakify1(qualifier, source, ...) _weakify2(qualifier, source, qualifier##Self)
#define _weakify2(qualifier, source, variable) _castify(qualifier, source, variable)

#define _strongify0(qualifier) _strongify1(qualifier, self)
#define _strongify1(qualifier, source) _strongify2(qualifier, source, qualifier##Self)
#define _strongify2(qualifier, source, variable) _castify(qualifier, source, variable)

#define _castify(qualifier, source, variable) __typeof(source) _qualifier(qualifier) variable = source;

#define _qualifier(qualifier) __##qualifier
#define _callX(_0, _1, _2, FUNC, ...) FUNC

#endif
