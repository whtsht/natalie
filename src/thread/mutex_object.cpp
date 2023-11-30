#include "natalie.hpp"

namespace Natalie::Thread {

Value MutexObject::lock(Env *env) {
    auto locked = m_mutex.try_lock();

    if (!locked) {
        if (ThreadObject::current() == m_thread) {
            env->raise("ThreadError", "deadlock; recursive locking");
        } else {
            Defer done_sleeping([] { ThreadObject::set_current_sleeping(false); });
            ThreadObject::set_current_sleeping(true);
            struct timespec request = { 0, 100000 };
            while (!m_mutex.try_lock())
                nanosleep(&request, nullptr);
        }
    }

    m_thread = ThreadObject::current();

    return this;
}

Value MutexObject::unlock(Env *env) {
    if (!is_locked())
        env->raise("ThreadError", "Attempt to unlock a mutex which is not locked");

    if (m_thread->status(env)->is_falsey())
        env->raise("ThreadError", "Attempt to unlock a mutex which is not locked");

    auto thread = m_thread;
    if (thread && thread != ThreadObject::current())
        env->raise("ThreadError", "Attempt to unlock a mutex which is locked by another thread/fiber");

    m_mutex.unlock();
    m_thread = nullptr;
    return this;
}

bool MutexObject::is_locked() {
    auto now_locked = m_mutex.try_lock();
    if (now_locked) {
        m_mutex.unlock();
        return false;
    }

    return true;
}

void MutexObject::visit_children(Visitor &visitor) {
    Object::visit_children(visitor);
    visitor.visit(m_thread);
}

}
