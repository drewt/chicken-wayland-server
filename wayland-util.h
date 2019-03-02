/*
 * Copyright © 2008 Kristian Høgsberg
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice (including the
 * next paragraph) shall be included in all copies or substantial
 * portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
 * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

struct wl_message {
	/** Message name */
	const char *name;
	/** Message signature */
	const char *signature;
	/** Object argument interfaces */
	const struct wl_interface **types;
};

struct wl_interface {
	/** Interface name */
	const char *name;
	/** Interface version */
	int version;
	/** Number of methods (requests) */
	int method_count;
	/** Method (request) signatures */
	const struct wl_message *methods;
	/** Number of events */
	int event_count;
	/** Event signatures */
	const struct wl_message *events;
};

struct wl_list {
	/** Previous list element */
	struct wl_list *prev;
	/** Next list element */
	struct wl_list *next;
};

void
wl_list_init(struct wl_list *list);

void
wl_list_insert(struct wl_list *list, struct wl_list *elm);

void
wl_list_remove(struct wl_list *elm);

int
wl_list_length(const struct wl_list *list);

//int
bool
wl_list_empty(const struct wl_list *list);

void
wl_list_insert_list(struct wl_list *list, struct wl_list *other);

struct wl_array {
	/** Array size */
	size_t size;
	/** Allocated space */
	size_t alloc;
	/** Array data */
	void *data;
};

void
wl_array_init(struct wl_array *array);

void
wl_array_release(struct wl_array *array);

void *
wl_array_add(struct wl_array *array, size_t size);

int
wl_array_copy(struct wl_array *array, struct wl_array *source);

typedef int32_t wl_fixed_t;

static inline double
wl_fixed_to_double(wl_fixed_t f)
{
	union {
		double d;
		int64_t i;
	} u;

	u.i = ((1023LL + 44LL) << 52) + (1LL << 51) + f;

	return u.d - (3LL << 43);
}

static inline wl_fixed_t
wl_fixed_from_double(double d)
{
	union {
		double d;
		int64_t i;
	} u;

	u.d = d + (3LL << (51 - 8));

	return u.i;
}

static inline int
wl_fixed_to_int(wl_fixed_t f)
{
	return f / 256;
}

static inline wl_fixed_t
wl_fixed_from_int(int i)
{
	return i * 256;
}

union wl_argument {
	int32_t i;           /**< `int`    */
	uint32_t u;          /**< `uint`   */
	wl_fixed_t f;        /**< `fixed`  */
	const char *s;       /**< `string` */
	struct wl_object *o; /**< `object` */
	uint32_t n;          /**< `new_id` */
	struct wl_array *a;  /**< `array`  */
	int32_t h;           /**< `fd`     */
};
