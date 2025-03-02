require 'llvm/core'
require 'llvm/execution_engine'

module Natalie
  class Compiler
    class LLVMBackend
      def initialize(instructions, compiler:, compiler_context:)
        puts "TODO: Implement LLVMBackend#initialize"
      end

      def interpret
        puts "TODO: Implement LLVMBackend#interpret"

        # mod = LLVM::Module.new('default')
        #
        # printf = mod.functions.add('printf', [LLVM.Pointer(LLVM::Int8)], LLVM::Int32)
        #
        # puts = mod.functions.add('puts', [LLVM::Int32], LLVM::Int32) do |func, num|
        #   func.basic_blocks.append.build do |b|
        #     format_str = b.global_string("%d\n")
        #     result = b.call printf, format_str, num
        #     b.ret result
        #   end
        # end
        #
        # main = mod.functions.add('main', [], LLVM::Int32) do |func|
        #   func.basic_blocks.append.build do |b|
        #     num = LLVM.Int(42)
        #     b.call puts, num
        #     b.ret LLVM::Int(0)
        #   end
        # end
        #
        # LLVM.init_jit
        #
        # LLVM::JITCompiler.new(mod).tap { |e| e.run_function(main); e.dispose }
      end

      def compile_to_binary
        puts "TODO: Implement LLVMBackend#compile_to_binary"
      end
    end
  end
end
