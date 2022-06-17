/// Task Status
///
/// The task status is different than the event status.
/// It is a reflection of the domain, an external, public
/// status, not a status used internally to trigger event
/// handling.
///
/// Copyright (c) Keith Pinson.
///
/// @see [[LICENSE]] file in the root directory of this source.
///

enum TaskStatus {
  backlog,
  todo,
  started,
  done
}
