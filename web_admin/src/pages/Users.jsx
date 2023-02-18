import React, { useState } from "react";

import { EditOutlined, DeleteOutlined } from "@ant-design/icons";
import Table from "../components/table/Table";
import { Link } from "react-router-dom";
import { Button, Form, Input, Modal } from "antd";
import customerList from "../assets/JsonData/customers-list.json";

const customerTableHead = [
  "",
  "tên",
  "email",
  "số điện thoại",
  "địa điểm",
  "",
  "",
];

const renderHead = (item, index) => <th key={index}>{item}</th>;

const Customers = () => {
  const renderBody = (item, index) => (
    <tr key={index}>
      <td>{item.id}</td>
      <td>
        <Link to={`/customer/${item.id}`}>{item.name}</Link>
      </td>
      <td>{item.email}</td>
      <td>{item.phone}</td>
      <td>{item.location}</td>
      <td>
        <Button type="link" icon={<EditOutlined />} onClick={showModal} />
      </td>
      <td>
        <Button type="link" icon={<DeleteOutlined />} />
      </td>
    </tr>
  );
  const [open, setOpen] = useState(false);
  const [openCreate, setOpenCreate] = useState(false);

  const showModal = () => {
    setOpen(true);
  };

  const hideModal = () => {
    setOpen(false);
  };

  const showModalCreate = () => {
    setOpenCreate(true);
  };

  const hideModalCreate = () => {
    setOpenCreate(false);
  };
  return (
    <div>
      <div className="row justify-between">
        <div className="col-3">
          <h2 className="page-header">Danh sách khách hàng</h2>
        </div>
        <div className="col-3">
          <div style={{ paddingRight: "55px" }} className="row justify-end">
            <Button type="primary" onClick={showModalCreate}>
              + Thêm mới khách hàng
            </Button>
          </div>
        </div>
      </div>
      <div className="row">
        <div className="col-12">
          <div className="card">
            <div className="card__body">
              <Table
                limit="10"
                headData={customerTableHead}
                renderHead={(item, index) => renderHead(item, index)}
                bodyData={customerList}
                renderBody={(item, index) => renderBody(item, index)}
              />
            </div>
          </div>
        </div>
      </div>
      <Modal
        title="Cập nhật thông tin khách hàng"
        open={open}
        onOk={hideModal}
        onCancel={hideModal}
        okText="OK"
        cancelText="Cancel"
      >
        <Form
          name="basic"
          labelCol={{ span: 8 }}
          wrapperCol={{ span: 16 }}
          style={{ maxWidth: 600 }}
          initialValues={{ remember: true }}
          //   onFinish={onFinish}
          //   onFinishFailed={onFinishFailed}
          autoComplete="off"
        >
          <Form.Item label="Tên" name="username">
            <Input />
          </Form.Item>
          <Form.Item label="Email" name="email">
            <Input />
          </Form.Item>
          <Form.Item label="Số điện thoại" name="phone">
            <Input />
          </Form.Item>
          <Form.Item label="Địa điểm" name="location">
            <Input />
          </Form.Item>
        </Form>
      </Modal>

      <Modal
        title="Thêm mới khách hàng"
        open={openCreate}
        onOk={hideModalCreate}
        onCancel={hideModalCreate}
        okText="OK"
        cancelText="Cancel"
      >
        <Form
          name="basic"
          labelCol={{ span: 8 }}
          wrapperCol={{ span: 16 }}
          style={{ maxWidth: 600 }}
          initialValues={{ remember: true }}
          //   onFinish={onFinish}
          //   onFinishFailed={onFinishFailed}
          autoComplete="off"
        >
          <Form.Item label="Tên" name="name">
            <Input />
          </Form.Item>
          <Form.Item label="Email" name="email">
            <Input />
          </Form.Item>
          <Form.Item label="Số điện thoại" name="phone">
            <Input />
          </Form.Item>

          <Form.Item label="Địa điểm" name="location">
            <Input />
          </Form.Item>
        </Form>
      </Modal>
    </div>
  );
};

export default Customers;
