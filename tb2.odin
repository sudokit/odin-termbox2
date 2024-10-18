package tb2

import "core:c"

Key :: enum u16 {
	Ctrl_Tilde       = 0x00,
	Ctrl_2           = 0x00,
	Ctrl_A           = 0x01,
	Ctrl_B           = 0x02,
	Ctrl_C           = 0x03,
	Ctrl_D           = 0x04,
	Ctrl_E           = 0x05,
	Ctrl_F           = 0x06,
	Ctrl_G           = 0x07,
	Backspace        = 0x08,
	Ctrl_H           = 0x08,
	Tab              = 0x09,
	Ctrl_I           = 0x09,
	Ctrl_J           = 0x0a,
	Ctrl_K           = 0x0b,
	Ctrl_L           = 0x0c,
	Enter            = 0x0d,
	Ctrl_M           = 0x0d,
	Ctrl_N           = 0x0e,
	Ctrl_O           = 0x0f,
	Ctrl_P           = 0x10,
	Ctrl_Q           = 0x11,
	Ctrl_R           = 0x12,
	Ctrl_S           = 0x13,
	Ctrl_T           = 0x14,
	Ctrl_U           = 0x15,
	Ctrl_V           = 0x16,
	Ctrl_W           = 0x17,
	Ctrl_X           = 0x18,
	Ctrl_Y           = 0x19,
	Ctrl_Z           = 0x1a,
	Esc              = 0x1b,
	Ctrl_Lsq_Bracket = 0x1b,
	Ctrl_3           = 0x1b,
	Ctrl_4           = 0x1c,
	Ctrl_Backslash   = 0x1c,
	Ctrl_5           = 0x1d,
	Ctrl_Rsq_Bracket = 0x1d,
	Ctrl_6           = 0x1e,
	Ctrl_7           = 0x1f,
	Ctrl_Slash       = 0x1f,
	Ctrl_Underscore  = 0x1f,
	Space            = 0x20,
	Backspace2       = 0x7f,
	Ctrl_8           = 0x7f,
	F1               = (0xffff - 0),
	F2               = (0xffff - 1),
	F3               = (0xffff - 2),
	F4               = (0xffff - 3),
	F5               = (0xffff - 4),
	F6               = (0xffff - 5),
	F7               = (0xffff - 6),
	F8               = (0xffff - 7),
	F9               = (0xffff - 8),
	F10              = (0xffff - 9),
	F11              = (0xffff - 10),
	F12              = (0xffff - 11),
	Insert           = (0xffff - 12),
	Delete           = (0xffff - 13),
	Home             = (0xffff - 14),
	End              = (0xffff - 15),
	Pgup             = (0xffff - 16),
	Pgdn             = (0xffff - 17),
	Arrow_Up         = (0xffff - 18),
	Arrow_Down       = (0xffff - 19),
	Arrow_Left       = (0xffff - 20),
	Arrow_Right      = (0xffff - 21),
	Back_Tab         = (0xffff - 22),
	Mouse_Left       = (0xffff - 23),
	Mouse_Right      = (0xffff - 24),
	Mouse_Middle     = (0xffff - 25),
	Mouse_Release    = (0xffff - 26),
	Mouse_Wheel_Up   = (0xffff - 27),
	Mouse_Wheel_Down = (0xffff - 28),
}

Event_Kind :: enum u8 {
	Key    = 1,
	Resize = 2,
	Mouse  = 3,
}

Input_Mode :: enum u8 {
	Current = 0,
	Esc     = 1,
	Alt     = 2,
	Mouse   = 4,
}

Output_Mode :: enum u8 {
	Current   = 0,
	Normal    = 1,
	O256      = 2,
	O216      = 3,
	Grayscale = 4,
}

Mod :: enum u8 {
	Alt    = 1,
	Ctrl   = 2,
	Shift  = 4,
	Motion = 8,
}

Color :: enum u16 {
	Default   = 0x0000,
	Black     = 0x0001,
	Red       = 0x0002,
	Green     = 0x0003,
	Yellow    = 0x0004,
	Blue      = 0x0005,
	Magenta   = 0x0006,
	Cyan      = 0x0007,
	White     = 0x0008,
	Bold      = 0x0100,
	Underline = 0x0200,
	Reverse   = 0x0400,
	Italic    = 0x0800,
	Blink     = 0x1000,
	Hi_black  = 0x2000,
	Bright    = 0x4000,
	Dim       = 0x8000,
}

Status :: enum {
	Ok               = 0,
	Err              = -1,
	Need_more        = -2,
	Init_Already     = -3,
	Init_Open        = -4,
	Mem              = -5,
	No_Event         = -6,
	No_Term          = -7,
	Not_Init         = -8,
	Out_Of_Bounds    = -9,
	Read             = -10,
	Resize_Ioctl     = -11,
	Resize_Pipe      = -12,
	Resize_Sigaction = -13,
	Poll             = -14,
	Tcgetattr        = -15,
	Tcsetattr        = -16,
	Unsupported_Term = -17,
	Resize_Write     = -18,
	Resize_Poll      = -19,
	Resize_Read      = -20,
	Resize_Sscanf    = -21,
	Cap_Collision    = -22,
	Select           = Poll,
	Resize_Select    = Resize_Poll,
}

Cell :: struct {
	ch:     rune,
	fg, bg: Color,
}

@(private = "file")
Vec2 :: [2]i32

Event :: struct {
	type: Event_Kind,
	mod:  Mod,
	key:  Key,
	ch:   rune,
	w, h: i32,
	x, y: i32,
}

foreign import termboxlib "system:termbox2"

@(default_calling_convention = "c", link_prefix = "tb_")
foreign termboxlib {
	init :: proc() -> Status ---
	init_file :: proc(path: cstring) -> Status ---
	init_fd :: proc(ttyfd: i32) -> Status ---
	init_rwfd :: proc(rfd, wfd: i32) -> Status ---
	shutdown :: proc() -> Status ---

	width :: proc() -> Status ---
	height :: proc() -> Status ---

	clear :: proc() -> Status ---
	set_clear_attrs :: proc(fg, bg: Color) -> Status ---

	present :: proc() -> Status ---

	invalidate :: proc() -> Status ---

	set_cursor :: proc(x, y: i32) -> Status ---
	hide_cursor :: proc() -> Status ---

	set_cell :: proc(x, y: i32, ch: rune, fg, bg: Color) -> Status ---
	extend_cell :: proc(x, y: i32, ch: rune) -> Status ---

	set_input_mode :: proc(mode: Input_Mode) -> Status ---
	set_output_mode :: proc(mode: Output_Mode) -> Status ---
	peek_event :: proc(event: ^Event, timeout_ms: i32) -> Status ---
	poll_event :: proc(event: ^Event) -> Status ---
	get_fds :: proc(ttyfd, resizefd: i32) -> Status ---
	print :: proc(x, y: i32, fg, bg: Color, str: cstring) -> Status ---
	printf :: proc(x, y: i32, fg, bg: Color, msg: cstring, format: ..any) -> Status ---
	utf8_char_length :: proc(c: rune) -> Status ---
	last_errno :: proc() -> Status ---
	strerror :: proc(err: Status) -> cstring ---
	attr_width :: proc() -> Status ---
	version :: proc() -> cstring ---
}

