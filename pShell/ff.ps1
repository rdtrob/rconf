funtion ff ([string] $glob)
{
    #get-childitem -recurse -include $glob
    get-childitem -filter $glob -recurse
}
