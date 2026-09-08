AddStategraphState('wilson',State{
    name = "betterlb_blanksg",
    onenter = function(inst)
        inst:PerformBufferedAction()
    end,
})

AddStategraphState('wilson_client',State{
    name = 'betterlb_blanksg',
    onenter = function(inst)
        inst:PerformPreviewBufferedAction()
    end,
})