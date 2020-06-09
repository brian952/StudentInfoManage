package pers.brian.stu.mod;

public class PageBean {
	private int page;//第几页
	private int rows;//页面记录数
	private int start;//起始页

	public PageBean(int page, int rows) {
		this.page = page;
		this.rows = rows;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public int getStart() {
		return (page-1)*rows;
	}

}
