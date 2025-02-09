#include "natalie.hpp"
#include <json-c/json.h>

using namespace Natalie;

Value init_json(Env *env, Value self) {
    return NilObject::the();
}

static json_object *ruby_to_json(Env *env, Value input) {
    if (input.is_nil()) {
        return json_object_new_null();
    } else if (input.is_true()) {
        return json_object_new_boolean(true);
    } else if (input.is_false()) {
        return json_object_new_boolean(false);
    } else if (input.is_integer()) {
        auto integer = input.integer();
        if (integer.is_bignum() || integer < static_cast<nat_int_t>(std::numeric_limits<int64_t>::min()) || integer > static_cast<nat_int_t>(std::numeric_limits<int64_t>::max())) {
            const auto d = integer.to_double();
            return json_object_new_double_s(d, integer.to_string().c_str());
        }
        return json_object_new_int64(integer.to_nat_int_t());
    } else if (input.is_float()) {
        const auto d = input->as_float()->to_double();
        return json_object_new_double_s(d, input.to_s(env)->c_str());
    } else if (input.is_string()) {
        auto str = input.to_str(env);
        return json_object_new_string_len(str->c_str(), str->bytesize());
    } else if (input.is_array()) {
        auto ary = input->as_array();
        auto res = json_object_new_array_ext(ary->size());
        for (auto elt : *ary)
            json_object_array_add(res, ruby_to_json(env, elt));
        return res;
    } else {
        env->raise("ArgumentError", "Unable to parse input: {}", input.inspect_str(env));
    }
}

Value JSON_generate_inner(Env *env, Value self, Args &&args, Block *) {
    args.ensure_argc_is(env, 1);
    auto res = ruby_to_json(env, args[0]);
    auto json_string = json_object_to_json_string_ext(res, JSON_C_TO_STRING_PLAIN);
    auto string = new StringObject { json_string, Encoding::ASCII_8BIT };
    json_object_put(res);
    return string;
}
