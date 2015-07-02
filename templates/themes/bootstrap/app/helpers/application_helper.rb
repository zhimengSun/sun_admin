module ApplicationHelper
  
  def table_class
    'table table-striped table-bordered table-hover'
  end

  def table_form_class
    'table table-form'
  end

  def link_btn(opts = {})
    primary_btn(opts)
  end

  def primary_btn(opts = {})
    style, size = [opts[:style] || 'primary', opts[:size] || 'big']
    'btn btn-' + style + ' btn-' + size
  end

  def submit_btn(title = t(:save), opts = {})
    submit_tag title, class: link_btn(style: opts[:style] || 'success mr10'), data: {disable_with: "#{opts[:disable_with] || title}中..."}
  end

  def save_and_return(f) 
    sub_btn = submit_btn 
    td = content_tag(:td, sub_btn + link_to_back(url: "/#{controller_name}"), colspan: "10", align: "center")
    content_tag(:tr, td, style: 'text-align: center')
  end

  def edit_with_delete(obj, opts = {})
    edit_btn = link_to('', "/" + controller_name + "/#{obj.id}/edit", class: 'glyphicon glyphicon-edit mr10')
    destroy_btn = link_to('', obj, data: {confirm: "确定删除么?"}, method: :delete, class: 'glyphicon glyphicon-trash')
    return edit_btn if opts[:hide_destory]
    edit_btn + destroy_btn
  end

  def link_to_back(opts = {}, html_opts = {})
    link_to_btn title: t(:back), btn_style: 'primary', url: opts[:url]
  end

  def link_to_btn(opts = {}, html_opts = {})
    title = opts[:title] || 'title'
    size = opts[:size] || 'btn-big'
    btn_style = opts[:btn_style] || 'primary'
    style = {class: "btn btn-#{btn_style} ml10 " + size}.merge(html_opts)
    return link_to title, opts[:url], style if opts[:url]
    link_to(title, '#', style.merge(onclick: "history.go(-1); return false;"))
  end

  def back_button
    link_to_back
  end
   
  def page_header(title, opts = {})
    htitle = content_tag(opts[:h] || :h3, title)
    content_tag(:div, htitle, class: "page-header")
  end

  def task_selector(time_type, end_no, start_no = 1)
    select :qtask, time_type, options_for_select([nil] + start_no.upto(end_no).to_a, @qtask.send(time_type))
  end

  def running_class(task)
    return "" unless controller_name =~ /tasks/ 
    return "gray" unless task.is_open
    h = task.histories.where(stat_date: Date.yesterday.to_s).first
    h.try(:running?) || @running_ids.include?(task.id) ? 'shine' : (h ? '' : 'red')
  end

  def status_class(col, obj)
    return "" unless obj.is_a?(History) && col == 'status_s'
    "status #{obj.status_s == 'success' ? 'green' : 'red'}"
  end

  def label_for(qtask)
    mins = qtask.predict_minutes
    label = content_tag(:label, "预计#{mins}分钟", class: "label label-warning") 
    raw "#{qtask.time} #{qtask.title} #{label}" 
  end

  def top_menus
    menu = []
    login_menu = [{"login" => ""}]
    menus = [
      {'admin' => %w(users roles resources)}
    ]
    return login_menu unless current_user
    return menus if current_user.is_admin?
    menu
  end
end
