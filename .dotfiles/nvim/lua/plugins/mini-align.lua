return {
 	 'nvim-mini/mini.align',
     version = false ,
    -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        start = 'ga',
        start_with_preview = 'gA',
      },

      -- Modifiers changing alignment steps and/or options
      config = function()
          require('mini.align').setup()
      end
}
