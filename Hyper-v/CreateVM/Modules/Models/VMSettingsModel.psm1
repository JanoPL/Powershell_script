class MemoryModel 
{
    [string] $Name;
    [int] $Memory;
    [bool] $MemoryDynamic = $false;
    [string] $VHDPath;
    [string] $VMSwitch;
    
    [string] GetName() {
        return $this.Name;
    } 
    
    [MemoryModel] SetName([string] $name) 
    {
        $this.Name = $name;
        return $this;
    }

    [int] GetMemory()
    {
        return $this.Memory;
    }

    [MemoryModel] SetMemory([int] $memory) 
    {
        $this.Memory = $memory;
        return $this;
    }

    [bool] GetMemoryDynamic()
    {
        return $this.MemoryDynamic;
    }

    [MemoryModel] SetMemoryDynamic([bool] $memoryDynamic)
    {
        $this.MemoryDynamic = $memoryDynamic;
        return $this;
    }

    [string] GetVHDPath()
    {
        return $this.VHDPath;
    }

    [MemoryModel] SetVHDPath([string] $vhdPath)
    {
        $this.VHDPath - $vhdPath;
        return $this;
    }

    [string] GetVMSwitch()
    {
        return $this.VMSwitch;
    }

    [MemoryModel] SetVMSwitch([string] $vmsSwitch) 
    {
        $this.VMSwitch = $vmsSwitch;
        return $this;
    }
}