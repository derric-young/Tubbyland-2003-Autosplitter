// State Code
state("tubbyland-2003-beta-6-5-21") {}
// Init/Update Code
init
{
	var scanner = new SignatureScanner(game, modules.First().BaseAddress, modules.First().ModuleMemorySize);
	var ptr = scanner.Scan(new SigScanTarget(2, "8B 3D ???????? 8B F7"));
	if (ptr == IntPtr.Zero) throw new NullReferenceException("Sigscanning failed!");
	vars.FrameID = new MemoryWatcher<int>(new DeepPointer(game.ReadPointer(ptr), game.ReadValue<int>(ptr + 0xC)));
}

update
{
	vars.FrameID.Update(game);
}
// AutoSplitter Code
// Start Timer Code
start {
  if(vars.FrameID.Current == 2 && vars.FrameID.Old == 1) {
    return true;
  }
}
// Split Code
split {
  if(vars.FrameID.Current == 0 && vars.FrameID.Old == 6) {
    return true;
  }
}
// Loading
isLoading {
  if(vars.FrameID.Current == 3) {
    return true;
  }
  else {
    return false;
  }
}
// Reseting Code
reset {
  if(vars.FrameID.Current == 1 && vars.FrameID.Old == 0) {
    return true;
  }
}