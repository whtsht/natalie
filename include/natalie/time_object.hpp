#pragma once

#include <time.h>

#include "natalie/forward.hpp"
#include "natalie/integer.hpp"
#include "natalie/object.hpp"
#include "tm/optional.hpp"

namespace Natalie {

class TimeObject : public Object {
public:
    enum class Mode {
        Localtime,
        UTC
    };

    TimeObject()
        : Object { Object::Type::Time, GlobalEnv::the()->Time() } { }

    TimeObject(ClassObject *klass)
        : Object { Object::Type::Time, klass } { }

    ~TimeObject() {
        free(m_zone);
    }

    static TimeObject *at(Env *, Value, Optional<Value> = {}, Optional<Value> = {});
    static TimeObject *at(Env *, Value, Optional<Value>, Optional<Value>, Optional<Value> in);
    static TimeObject *create(Env *);
    static TimeObject *initialize(Env *, Optional<Value>, Optional<Value>, Optional<Value>, Optional<Value>, Optional<Value>, Optional<Value>, Optional<Value>, Optional<Value> in);
    static TimeObject *local(Env *, Value, Optional<Value>, Optional<Value>, Optional<Value>, Optional<Value>, Optional<Value>, Optional<Value>);
    static TimeObject *now(Env *, Optional<Value> in = {});
    static TimeObject *utc(Env *, Value, Optional<Value>, Optional<Value>, Optional<Value>, Optional<Value>, Optional<Value>, Optional<Value>);

    Value add(Env *, Value);
    Value asctime(Env *);
    Value cmp(Env *, Value);
    bool eql(Env *, Value);
    Value hour(Env *) const;
    Value inspect(Env *);
    bool isdst(Env *) const { return m_time.tm_isdst > 0; }
    // NATFIXME: This one is broken, it returns true for `Time.new(2000, 1, 1, 20, 15, 01, 3600)`
    bool is_utc(Env *) const { return m_mode == Mode::UTC; }
    Value mday(Env *) const;
    Value min(Env *) const;
    Value minus(Env *, Value);
    Value month(Env *) const;
    Value nsec(Env *);
    Value sec(Env *) const;
    Value strftime(Env *, Value);
    Value subsec(Env *);
    Value to_a(Env *) const;
    Value to_f(Env *);
    Value to_i(Env *) const { return m_integer; }
    Value to_r(Env *);
    Value to_s(Env *);
    Value to_utc(Env *);
    Value usec(Env *);
    Value utc_offset(Env *) const;
    Value wday(Env *) const;
    Value yday(Env *) const;
    Value year(Env *) const;
    Value zone(Env *) const;

    virtual void visit_children(Visitor &visitor) const override {
        Object::visit_children(visitor);
        visitor.visit(m_integer);
        if (m_subsec)
            visitor.visit(m_subsec.value());
    }

    virtual void gc_inspect(char *buf, size_t len) const override {
        snprintf(buf, len, "<TimeObject %p>", this);
    }

private:
    static RationalObject *convert_rational(Env *, Value);
    static Value convert_unit(Env *, Value);
    static TimeObject *create(Env *, RationalObject *, Mode);

    static nat_int_t normalize_month(Env *, Value val);
    static nat_int_t normalize_field(Env *, Value val);
    static nat_int_t normalize_field(Env *, Value val, nat_int_t minval, nat_int_t maxval);
    static nat_int_t normalize_timezone(Env *, Value val);

    Value build_string(Env *, const char *);
    void build_time(Env *, Value, Optional<Value>, Optional<Value>, Optional<Value>, Optional<Value>, Optional<Value>);
    void set_subsec(Env *, long);
    void set_subsec(Env *, Integer);
    void set_subsec(Env *, RationalObject *);
    Value strip_zeroes(StringObject *);

    Integer m_integer;
    Mode m_mode;
    Optional<Value> m_subsec;
    struct tm m_time;
    char *m_zone { nullptr };
};

}
