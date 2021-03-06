
class ExportTestcases
  def self.create testcases, file_path, file_name

    p =  Axlsx::Package.new
    p.workbook do |wb|
      styles = wb.styles
      tbl_header  = styles.add_style :b => true, :alignment => { :horizontal => :center }
      left_align  = styles.add_style alignment: {horizontal: :left}
      wrap_text   = styles.add_style :alignment => {:wrap_text => true}


      wb.add_worksheet do |sheet|
        sheet.name = 'Test Cases'
        sheet.add_row ["Test ID", 'Title', 'Steps', 'Expected Result'], :style => tbl_header
        testcases.each do |tc|
          steps = []
          results = []
          if tc.reproduction_steps
            tc.reproduction_steps.each do |step|
              steps.append("#{step['step_number']}.  #{step['action']}")
              results.append("#{step['step_number']}.  #{step['result']}")
            end
          end

          sheet.add_row [tc.validation_id, tc.name, steps.join("\n"), results.join("\n")], style: [left_align, wrap_text, wrap_text, wrap_text]
        end
        sheet.column_widths 10, 30, 100, 100
      end
    end
    p.use_shared_strings = true
    p.serialize file_path

  end
end


