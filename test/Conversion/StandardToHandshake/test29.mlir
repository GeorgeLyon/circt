// NOTE: Assertions have been autogenerated by utils/update_mlir_test_checks.py
// RUN: circt-opt -create-dataflow %s | FileCheck %s
func @load_store(memref<4x4xi32>, index) {
// CHECK:       module {

// CHECK-LABEL:   handshake.func @load_store(
// CHECK-SAME:                               %[[VAL_0:.*]]: memref<4x4xi32>, %[[VAL_1:.*]]: index, %[[VAL_2:.*]]: none, ...) -> none {
// CHECK:           %[[VAL_3:.*]]:4 = "handshake.memory"(%[[VAL_4:.*]]#0, %[[VAL_4]]#1, %[[VAL_5:.*]]#0, %[[VAL_5]]#1) {id = 0 : i32, ld_count = 2 : i32, lsq = false, st_count = 0 : i32, type = memref<4x4xi32>} : (index, index, index, index) -> (i32, i32, none, none)
// CHECK:           %[[VAL_6:.*]] = "handshake.merge"(%[[VAL_0]]) : (memref<4x4xi32>) -> memref<4x4xi32>
// CHECK:           "handshake.sink"(%[[VAL_6]]) : (memref<4x4xi32>) -> ()
// CHECK:           %[[VAL_7:.*]] = "handshake.merge"(%[[VAL_1]]) : (index) -> index
// CHECK:           %[[VAL_8:.*]]:4 = "handshake.fork"(%[[VAL_7]]) {control = false} : (index) -> (index, index, index, index)
// CHECK:           %[[VAL_9:.*]]:3 = "handshake.fork"(%[[VAL_2]]) {control = true} : (none) -> (none, none, none)
// CHECK:           %[[VAL_10:.*]] = "handshake.join"(%[[VAL_9]]#2, %[[VAL_3]]#2, %[[VAL_3]]#3) {control = true} : (none, none, none) -> none
// CHECK:           %[[VAL_11:.*]], %[[VAL_4]]:2 = "handshake.load"(%[[VAL_8]]#2, %[[VAL_8]]#3, %[[VAL_3]]#0, %[[VAL_9]]#1) : (index, index, i32, none) -> (i32, index, index)
// CHECK:           "handshake.sink"(%[[VAL_11]]) : (i32) -> ()
// CHECK:           %[[VAL_12:.*]], %[[VAL_5]]:2 = "handshake.load"(%[[VAL_8]]#0, %[[VAL_8]]#1, %[[VAL_3]]#1, %[[VAL_9]]#0) : (index, index, i32, none) -> (i32, index, index)
// CHECK:           "handshake.sink"(%[[VAL_12]]) : (i32) -> ()
// CHECK:           handshake.return %[[VAL_10]] : none
// CHECK:         }
// CHECK:       }

^bb0(%0: memref<4x4xi32>, %1: index):
  %2 = "std.load"(%0, %1, %1) : (memref<4x4xi32>, index, index)->i32
  %3 = load %0[%1, %1] : memref<4x4xi32>
  return
}
