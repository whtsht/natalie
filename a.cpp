#include "natalie.hpp"

using namespace Natalie;

#ifdef NAT_PRINT_OBJECTS
#define NAT_GC_DISABLE
#endif

Value init_exception(Env *env, Value self);
Value init_array(Env *env, Value self);
Value init_comparable(Env *env, Value self);
Value init_complex(Env *env, Value self);
Value init_data(Env *env, Value self);
Value init_dir(Env *env, Value self);
Value init_encoding_converter(Env *env, Value self);
Value init_enumerable(Env *env, Value self);
Value init_enumerator(Env *env, Value self);
Value init_errno(Env *env, Value self);
Value init_file(Env *env, Value self);
Value init_gc(Env *env, Value self);
Value init_hash(Env *env, Value self);
Value init_integer(Env *env, Value self);
Value init_io(Env *env, Value self);
Value init_kernel(Env *env, Value self);
Value init_marshal(Env *env, Value self);
Value init_math(Env *env, Value self);
Value init_numeric(Env *env, Value self);
Value init_proc(Env *env, Value self);
Value init_process(Env *env, Value self);
Value init_random(Env *env, Value self);
Value init_range(Env *env, Value self);
Value init_rbconfig(Env *env, Value self);
Value init_string(Env *env, Value self);
Value init_struct(Env *env, Value self);
Value init_struct_process_tms(Env *env, Value self);
Value init_thread_conditionvariable(Env *env, Value self);
Value init_thread_queue(Env *env, Value self);
Value init_time(Env *env, Value self);
Value init_warning(Env *env, Value self);

static SymbolObject *symbols[8] = {};



Value defn_a2(Env *env, Value self, Args &&args, Block *block) {
    args.ensure_argc_is(env, 0, {  });
    Value string3 = Value(new StringObject("a", (size_t)1, EncodingObject::get(Encoding::UTF_8)));
    string3.as_string()->set_chilled(StringObject::Chilled::String);
    return string3;
}
Value defn_cvar_m4(Env *env, Value self, Args &&args, Block *block) {
    args.ensure_argc_is(env, 0, {  });
    Value cvar5 = self->cvar_get(env, symbols[1]/*:@@cvar_m*/);
    return cvar5;
}
Value module_ModuleM1(Env *env, Value self) {
    self->cvar_set(env, symbols[1]/*:@@cvar_m*/, Value(symbols[0]/*:value*/));
    env->set_file("a.rb");
    env->set_line(4);
    Object::define_method(env, self, symbols[2]/*:a*/, defn_a2, 0);
    env->set_file("a.rb");
    env->set_line(8);
    Object::define_method(env, self, symbols[3]/*:cvar_m*/, defn_cvar_m4, 0);
    return Value(symbols[3]/*:cvar_m*/);
}
Value class_ClassC9(Env *env, Value self) {
    env->set_file("a.rb");
    env->set_line(14);
    Value const10 = Object::const_find_with_autoload(env, self, self, symbols[4]/*:ModuleM*/, Object::ConstLookupSearchMode::NotStrict, Object::ConstLookupFailureMode::ConstMissing).value();
    Value send_extend11 = self.send(env, symbols[5]/*:extend*/, Args({ const10 }, false), nullptr);
    return send_extend11;
}

extern "C" Env *build_top_env() {
    auto env = Natalie::build_top_env();
    [[maybe_unused]] Value self = GlobalEnv::the()->main_obj();
    init_exception(env, self);
    init_array(env, self);
    init_comparable(env, self);
    init_complex(env, self);
    init_data(env, self);
    init_dir(env, self);
    init_encoding_converter(env, self);
    init_enumerable(env, self);
    init_enumerator(env, self);
    init_errno(env, self);
    init_file(env, self);
    init_gc(env, self);
    init_hash(env, self);
    init_integer(env, self);
    init_io(env, self);
    init_kernel(env, self);
    init_marshal(env, self);
    init_math(env, self);
    init_numeric(env, self);
    init_proc(env, self);
    init_process(env, self);
    init_random(env, self);
    init_range(env, self);
    init_rbconfig(env, self);
    init_string(env, self);
    init_struct(env, self);
    init_struct_process_tms(env, self);
    init_thread_conditionvariable(env, self);
    init_thread_queue(env, self);
    init_time(env, self);
    init_warning(env, self);
    return env;
}

extern "C" int EVAL(Env *env, Value *result_memory) {
    symbols[0] = SymbolObject::intern("value", 5);
    symbols[1] = SymbolObject::intern("@@cvar_m", 8);
    symbols[2] = SymbolObject::intern("a", 1);
    symbols[3] = SymbolObject::intern("cvar_m", 6);
    symbols[4] = SymbolObject::intern("ModuleM", 7);
    symbols[5] = SymbolObject::intern("extend", 6);
    symbols[6] = SymbolObject::intern("ClassC", 6);
    symbols[7] = SymbolObject::intern("puts", 4);
    
    
    
    env->global_set("$0"_s, new StringObject { "a.rb" });
    
    [[maybe_unused]] Value self = GlobalEnv::the()->main_obj();
    volatile bool run_exit_handlers = true;
    
    // kinda hacky, but needed for top-level begin/rescue
    Args args;
    Block *block = nullptr;
    
    Value result = Value::nil();
    try {
        // FIXME: top-level `return` in a Ruby script should probably be changed to `exit`.
        result = [&]() -> Value {
            env->set_file("a.rb");
            env->set_line(1);
            Value module6;
            auto module_found7 = Object::const_find_with_autoload(env, self, self, symbols[4]/*:ModuleM*/, Object::ConstLookupSearchMode::StrictPrivate, Object::ConstLookupFailureMode::None);
            if (module_found7) {
                module6 = module_found7.value();
                if (!module6.is_module() || module6.is_class()) {
                    env->raise("TypeError", "ModuleM is not a module");
                }
            } else {
                module6 = new ModuleObject("ModuleM");
                Object::const_set(env, self, symbols[4]/*:ModuleM*/, module6);
            }
            Value result_of_define_module8 = module6.as_module()->eval_body(env, module_ModuleM1);
            env->set_file("a.rb");
            env->set_line(13);
            Value class12;
            auto class_found13 = Object::const_find_with_autoload(env, self, self, symbols[6]/*:ClassC*/, Object::ConstLookupSearchMode::StrictPrivate, Object::ConstLookupFailureMode::None);
            if (class_found13) {
                class12 = class_found13.value();
                if (!class12.is_class()) {
                    env->raise("TypeError", "ClassC is not a class");
                }
            } else {
                class12 = Object::subclass(env, GlobalEnv::the()->Object(), "ClassC");
                Object::const_set(env, self, symbols[6]/*:ClassC*/, class12);
            }
            Value result_of_define_class14 = class12.as_class()->eval_body(env, class_ClassC9);
            env->set_file("a.rb");
            env->set_line(17);
            Value const15 = Object::const_find_with_autoload(env, self, self, symbols[6]/*:ClassC*/, Object::ConstLookupSearchMode::NotStrict, Object::ConstLookupFailureMode::ConstMissing).value();
            Value send_a16 = const15.public_send(env, symbols[2]/*:a*/, Args({  }, false), nullptr, self);
            Value send_puts17 = self.send(env, symbols[7]/*:puts*/, Args({ send_a16 }, false), nullptr);
            return send_puts17;
            return Value::nil();
        }();
        run_exit_handlers = false;
        run_at_exit_handlers(env);
    } catch (ExceptionObject *exception) {
        handle_top_level_exception(env, exception, run_exit_handlers);
        return 1;
    }
    memcpy(result_memory, &result, sizeof(Value));
    return 0;
}

int main(int argc, char *argv[]) {
#ifdef NAT_NATIVE_PROFILER
    NativeProfiler::enable();
#endif
    
    setvbuf(stdout, nullptr, _IOLBF, 1024);
    
    Env *env = ::build_top_env();
    ThreadObject::finish_main_thread_setup(env, __builtin_frame_address(0));
    
    trap_signal(SIGINT, sigint_handler);
    trap_signal(SIGPIPE, sigpipe_handler);
#if !defined(__APPLE__)
    trap_signal(SIGUSR1, gc_signal_handler);
    trap_signal(SIGUSR2, gc_signal_handler);
#endif
    
#ifndef NAT_GC_DISABLE
    Heap::the().gc_enable();
#endif
#ifdef NAT_GC_COLLECT_ALL_AT_EXIT
    Heap::the().set_collect_all_at_exit(true);
#endif
    
    if (argc > 0) {
        Value exe = new StringObject { argv[0] };
        env->global_set("$exe"_s, exe);
    }
    
    ArrayObject *ARGV = new ArrayObject { (size_t)argc };
    GlobalEnv::the()->Object()->const_set("ARGV"_s, ARGV);
    for (int i = 1; i < argc; i++) {
        ARGV->push(new StringObject { argv[i] });
    }
    
    Value result = Value::nil();
    auto return_code = EVAL(env, &result);
    
#ifdef NAT_NATIVE_PROFILER
    NativeProfiler::the()->dump();
#endif
#ifdef NAT_PRINT_OBJECTS
    Heap::the().dump();
#endif
    clean_up_and_exit(return_code);
}
--------------------------------------------------------------------------------
/tmp/natalie.cpp20250304-70-apwxig
