require 'llvm/core'
require 'llvm/execution_engine'

module Natalie
  class Compiler
    class LLVMBackend
      class Transform
        def initialize(instructions)
          @instructions = instructions
        end

        def transfrom
          @instructions.walk do |instruction|
            # instruction.generate(self)
            puts instruction.class
          end
          LLVMManager.new
        end

        def push(result)
          # puts "push " + result.to_s
        end
      end

      class LLVMManager
        def initialize
        end

        def run_jit
          mod = LLVM::Module.new('default')

          printf = mod.functions.add('printf', [LLVM.Pointer(LLVM::Int8)], LLVM::Int32)

          puts = mod.functions.add('puts', [LLVM::Int32], LLVM::Int32) do |func, num|
            func.basic_blocks.append.build do |b|
              format_str = b.global_string("%d\n")
              result = b.call printf, format_str, num
              b.ret result
            end
          end

          main = mod.functions.add('main', [], LLVM::Int32) do |func|
            func.basic_blocks.append.build do |b|
              num = LLVM.Int(42)
              b.call puts, num
              b.ret LLVM::Int(0)
            end
          end

          LLVM.init_jit

          LLVM::JITCompiler.new(mod).tap { |e| e.run_function(main); e.dispose }
        end
      end

      def initialize(instructions, compiler:, compiler_context:)
        @instructions = instructions
        @compiler = compiler
        @compiler_context = compiler_context
      end

      def interpret
        transfrom = Transform.new(@instructions)
        llvm = transfrom.transfrom
        llvm.run_jit
      end

      def compile_to_binary
        puts "TODO: Implement LLVMBackend#compile_to_binary"
      end
    end
  end
end
