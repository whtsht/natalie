#include "natalie.hpp"

namespace Natalie {

static const long WINDOWS1250[] = {
    0x20AC, -1, 0x201A, -1, 0x201E, 0x2026, 0x2020, 0x2021, -1, 0x2030,
    0x160, 0x2039, 0x15A, 0x164, 0x17D, 0x179, -1, 0x2018, 0x2019, 0x201C,
    0x201D, 0x2022, 0x2013, 0x2014, -1, 0x2122, 0x161, 0x203A, 0x15B, 0x165,
    0x17E, 0x17A, 0xA0, 0x2C7, 0x2D8, 0x141, 0xA4, 0x104, 0xA6, 0xA7,
    0xA8, 0xA9, 0x15E, 0xAB, 0xAC, 0xAD, 0xAE, 0x17B, 0xB0, 0xB1,
    0x2DB, 0x142, 0xB4, 0xB5, 0xB6, 0xB7, 0xB8, 0x105, 0x15F, 0xBB,
    0x13D, 0x2DD, 0x13E, 0x17C, 0x154, 0xC1, 0xC2, 0x102, 0xC4, 0x139,
    0x106, 0xC7, 0x10C, 0xC9, 0x118, 0xCB, 0x11A, 0xCD, 0xCE, 0x10E,
    0x110, 0x143, 0x147, 0xD3, 0xD4, 0x150, 0xD6, 0xD7, 0x158, 0x16E,
    0xDA, 0x170, 0xDC, 0xDD, 0x162, 0xDF, 0x155, 0xE1, 0xE2, 0x103,
    0xE4, 0x13A, 0x107, 0xE7, 0x10D, 0xE9, 0x119, 0xEB, 0x11B, 0xED,
    0xEE, 0x10F, 0x111, 0x144, 0x148, 0xF3, 0xF4, 0x151, 0xF6, 0xF7,
    0x159, 0x16F, 0xFA, 0x171, 0xFC, 0xFD, 0x163, 0x2D9
};

Windows1250EncodingObject::Windows1250EncodingObject()
    : SingleByteEncodingObject { Encoding::Windows_1250, { "Windows-1250", "CP1250" }, WINDOWS1250 } { }

}
