//
//  CPMRAMModule.m
//  CPM for OS X
//
//  Created by Thomas Harte on 12/09/2012.
//  Copyright (c) 2012 Thomas Harte. All rights reserved.
//

#import "RAMModule.h"

@implementation CPMRAMModule
{
	uint8_t *_storage;
}

- (id)init
{
	self = [super init];

	if(self)
	{
		_storage = (uint8_t *)calloc(65536, sizeof(uint8_t));
	}

	return self;
}

- (void)dealloc
{
	if(_storage) free(_storage);
	_storage = NULL;
}

- (void)setValue:(uint8_t)value atAddress:(uint16_t)address		{	_storage[address] = value;	}
- (uint8_t)valueAtAddress:(uint16_t)address						{	return _storage[address];	}
- (uint8_t *)pointerToAddress:(uint16_t)address					{	return &_storage[address];	}

- (void)setData:(NSData *)data atAddress:(uint16_t)address
{
	size_t length = data.length;
	if(address+length > 65536) length = 65536 - address;
	memcpy(&_storage[address], data.bytes, length);
}

- (NSData *)dataAtAddress:(uint16_t)address length:(size_t)length
{
	if(length + address > 65536) length = 65536 - address;
	return [NSData dataWithBytes:&_storage[address] length:length];
}

@end
